class Remake < Formula
  desc "GNU Make with improved error handling, tracing, and a debugger"
  homepage "https://bashdb.sourceforge.net/remake/"
  url "https://downloads.sourceforge.net/project/bashdb/remake/4.3%2Bdbg-1.6/remake-4.3%2Bdbg-1.6.tar.gz"
  version "4.3-1.6"
  sha256 "f6a0c6179cd92524ad5dd04787477c0cd45afb5822d977be93d083b810647b87"
  license "GPL-3.0-only"

  # We check the "remake" directory page because the bashdb project contains
  # various software and remake releases may be pushed out of the SourceForge
  # RSS feed.
  livecheck do
    url "https://sourceforge.net/projects/bashdb/files/remake/"
    regex(%r{href=.*?remake/v?(\d+(?:\.\d+)+(?:(?:%2Bdbg)?[._-]\d+(?:\.\d+)+)?)/?["' >]}i)
    strategy :page_match do |page, regex|
      page.scan(regex).map { |match| match&.first&.sub(/%2Bdbg/i, "") }
    end
  end



  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "54d511c8ba16acd288038f8af790177d228230c07b69e729f8859c79ea9bee51"
  end

  depends_on "readline"

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "buildaux/#{cf}", "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}", "dist/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    # GNU make 4.3's K&R-style empty parameter lists are not valid C23
    # prototypes; build in C17 with the historical implicit declarations.
    ENV.append_to_cflags "-std=gnu17 -Wno-error=implicit-int -Wno-error=implicit-function-declaration"
    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--disable-silent-rules", *std_configure_args
    system "make", "install"
    # Remove texinfo files for make to avoid conflict
    rm info.glob("make.info*")
  end

  test do
    (testpath/"Makefile").write <<~MAKE
      all:
      	echo "Nothing here, move along"
    MAKE
    system bin/"remake", "-x"
  end
end
