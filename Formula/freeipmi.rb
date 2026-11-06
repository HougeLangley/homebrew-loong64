class Freeipmi < Formula
  desc "In-band and out-of-band IPMI (v1.5/2.0) software"
  homepage "https://www.gnu.org/software/freeipmi/"
  url "https://ftpmirror.gnu.org/freeipmi/freeipmi-1.6.20.tar.gz"
  mirror "https://ftp.gnu.org/gnu/freeipmi/freeipmi-1.6.20.tar.gz"
  sha256 "9cc644530ee629ffb94d6fd209e7cb4a8b8ae6677f89d2dc461efed9b2e709f2"
  license "GPL-3.0-or-later"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "945f1c2d8ac1f0df1c10eb883dcdaba4bdd0ab85305fa77392d2fe9ae442af5e"
  end


  depends_on "texinfo" => :build
  depends_on "libgcrypt"

  on_macos do
    depends_on "argp-standalone"
  end

  # Fix -flat_namespace being used on Big Sur and later.
  patch do
    file "Patches/libtool/configure-big_sur.diff"
  end

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    # Fix compile with newer Clang
    ENV.append_to_cflags "-Wno-implicit-function-declaration" if DevelopmentTools.clang_build_version >= 1403

    # Hardcode CPP_FOR_BUILD to work around cpp shim issue:
    # https://github.com/Homebrew/brew/issues/5153
    inreplace "man/Makefile.in", "$(CPP_FOR_BUILD)", "#{ENV.cxx} -E"

    system "./configure", "--build=loongarch64-unknown-linux-gnu", *std_configure_args
    system "make", "install"
  end

  test do
    system sbin/"ipmi-fru", "--version"
  end
end
