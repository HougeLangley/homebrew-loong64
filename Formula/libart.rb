class Libart < Formula
  desc "Library for high-performance 2D graphics"
  homepage "https://gitlab.gnome.org/Archive/libart_lgpl"
  url "https://download.gnome.org/sources/libart_lgpl/2.3/libart_lgpl-2.3.21.tar.bz2"
  sha256 "fdc11e74c10fc9ffe4188537e2b370c0abacca7d89021d4d303afdf7fd7476fa"
  license "LGPL-2.0-or-later"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "c24bf279efcb3473d8b7b9957788f3f7f190ebf37cb31439e86942671b52766c"
  end

  # We use a common regex because libart doesn't use GNOME's "even-numbered
  # minor is stable" version scheme.
  livecheck do
    url :stable
    regex(/libart_lgpl[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  deprecate! date: "2026-07-17", because: :repo_archived
  disable! date: "2027-01-17", because: :repo_archived

  # Fix -flat_namespace being used on Big Sur and later.
  patch do
    file "Patches/libtool/configure-pre-0.4.2.418-big_sur.diff"
  end

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    args = []
    # Help old config scripts identify arm64 linux
    args << "--build=aarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    args << "--build=loongarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arch == :loongarch64

    system "./configure", *args, *std_configure_args
    system "make", "install"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/libart2-config --version")

    (testpath/"test.c").write <<~C
      #include <libart_lgpl/art_svp.h>
      int main(void) {
        return 0;
      }
    C

    system ENV.cc, "-o", "test", "test.c", "-I#{include}/libart-2.0", "-L#{lib}", "-lart_lgpl_2"
    system "./test"
  end
end
