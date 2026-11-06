class Libdaemon < Formula
  desc "C library that eases writing UNIX daemons"
  homepage "https://0pointer.de/lennart/projects/libdaemon/"
  url "https://0pointer.de/lennart/projects/libdaemon/libdaemon-0.14.tar.gz"
  sha256 "fd23eb5f6f986dcc7e708307355ba3289abe03cc381fc47a80bca4a50aa6b834"
  license "LGPL-2.1-or-later"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "c8db8703d254f6e12cc982cc98ad815e1a02c309f1a2d2dc07b1e7881fa5e246"
  end

  livecheck do
    url :homepage
    regex(/href=.*?libdaemon[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  depends_on "pkgconf" => :test

  # Fix -flat_namespace being used on Big Sur and later.
  patch do
    file "Patches/libtool/configure-pre-0.4.2.418-big_sur.diff"
  end

  deny_network_access!

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    args = ["--disable-silent-rules"]
    # Help old config scripts identify arm64 linux
    args << "--build=aarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    args << "--build=loongarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arch == :loongarch64

    system "./configure", *std_configure_args, *args
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <stdio.h>
      #include <libdaemon/daemon.h>

      int main(void) {
        printf("%s\\n", daemon_ident_from_argv0("/usr/sbin/testd"));
        return 0;
      }
    C

    pkgconf_flags = shell_output("pkgconf --cflags --libs libdaemon").chomp.split
    system ENV.cc, "test.c", "-o", "test", *pkgconf_flags
    assert_equal "testd", shell_output("./test").strip
  end
end
