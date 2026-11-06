class Schroedinger < Formula
  desc "High-speed implementation of the Dirac codec"
  homepage "https://launchpad.net/schroedinger"
  url "https://launchpad.net/schroedinger/trunk/1.0.11/+download/schroedinger-1.0.11.tar.gz"
  mirror "https://deb.debian.org/debian/pool/main/s/schroedinger/schroedinger_1.0.11.orig.tar.gz"
  sha256 "1e572a0735b92aca5746c4528f9bebd35aa0ccf8619b22fa2756137a8cc9f912"
  license any_of: ["MPL-1.1", "LGPL-2.0-only", "GPL-2.0-only", "MIT"]


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "2e46ff2214840d9cba7590e0523cceedc86a8ae295cfef0488033d6d9fedc358"
  end

  depends_on "pkgconf" => [:build, :test]
  depends_on "orc"

  deny_network_access!

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
    args << "--build=loongarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arch == :loongarch64

    system "./configure", *args, *std_configure_args

    # The test suite is known not to build against Orc >0.4.16 in Schroedinger 1.0.11.
    # A fix is in upstream, so test when pulling 1.0.12 if this is still needed. See:
    # https://www.mail-archive.com/schrodinger-devel@lists.sourceforge.net/msg00415.html
    inreplace "Makefile" do |s|
      s.change_make_var! "SUBDIRS", "schroedinger doc tools"
      s.change_make_var! "DIST_SUBDIRS", "schroedinger doc tools"
    end

    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <schroedinger/schro.h>

      int main(void) {
        schro_init();
        SchroEncoder *encoder = schro_encoder_new();
        if (encoder == NULL) return 1;
        schro_encoder_free(encoder);
        return 0;
      }
    C

    pkgconf_flags = shell_output("pkgconf --cflags --libs schroedinger-1.0").chomp.split
    system ENV.cc, "test.c", "-o", "test", *pkgconf_flags
    system "./test"
  end
end
