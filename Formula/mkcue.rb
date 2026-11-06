class Mkcue < Formula
  desc "Generate a CUE sheet from a CD"
  homepage "https://packages.debian.org/sid/mkcue"
  url "https://deb.debian.org/debian/pool/main/m/mkcue/mkcue_1.orig.tar.gz"
  sha256 "2aaf57da4d0f2e24329d5e952e90ec182d4aa82e4b2e025283e42370f9494867"
  license "LGPL-2.1-or-later"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "9c7988be5200d010fcae9be133b6fa918fff50d5e236b191b4f965202c5a7034"
  end

  livecheck do
    url :homepage
    regex(/href=.*?mkcue[._-]v?(\d+(?:\.\d+)*)\.orig\.t/i)
  end


  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    ENV.cxx11
    args = []
    # Help old config scripts identify arm64 linux
    args << "--build=aarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    args << "--build=loongarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arch == :loongarch64

    system "./configure", *args, *std_configure_args
    bin.mkpath
    system "make", "install"
  end

  test do
    touch testpath/"test"
    system bin/"mkcue", "test" unless ENV["HOMEBREW_GITHUB_ACTIONS"]

    if ENV["HOMEBREW_GITHUB_ACTIONS"]
      if OS.mac?
        system bin/"mkcue", "test"
      elsif OS.linux?
        assert_match "Cannot read table of contents", shell_output("#{bin}/mkcue test 2>&1", 2)
      end
    end
  end
end
