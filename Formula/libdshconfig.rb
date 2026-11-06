class Libdshconfig < Formula
  desc "Distributed shell library"
  homepage "https://www.netfort.gr.jp/~dancer/software/dsh.html.en"
  url "https://www.netfort.gr.jp/~dancer/software/downloads/libdshconfig-0.20.13.tar.gz"
  sha256 "6f372686c5d8d721820995d2b60d2fda33fdb17cdddee9fce34795e7e98c5384"
  license "GPL-2.0-or-later"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "f8d9e6492085d32429f005ad1b7b2855d0077950e80d64d6f603b30b5a3adbd8"
  end

  livecheck do
    url "https://www.netfort.gr.jp/~dancer/software/downloads/"
    regex(/href=.*?libdshconfig[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    # Run autoreconf to regenerate the configure script and update outdated macros.
    # This ensures that the build system is properly configured on both macOS
    # (avoiding issues like flat namespace conflicts) and Linux (where outdated
    # config scripts may fail to detect the correct build type).
    system "autoreconf", "--force", "--install", "--verbose"

    system "./configure", "--build=loongarch64-unknown-linux-gnu", *std_configure_args
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <libdshconfig.h>
      int main(void) {
        return 0;
      }
    C

    system ENV.cc, "test.c", "-I#{include}", "-L#{lib}", "-ldshconfig", "-o", "test"
    system "./test"
  end
end
