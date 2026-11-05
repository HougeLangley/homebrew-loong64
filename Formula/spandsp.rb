class Spandsp < Formula
  desc "DSP functions library for telephony"
  homepage "https://web.archive.org/web/20260820112501/https://www.soft-switch.org/"
  url "https://cdn.netbsd.org/pub/pkgsrc/distfiles/spandsp-0.0.6.tar.gz"
  sha256 "cc053ac67e8ac4bb992f258fd94f275a7872df959f6a87763965feabfdcc9465"
  license "LGPL-2.1-only"
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "90c773a8cdf0f4f065272804596c6d0dc1df1609ce019a980e57430e7a975c0c"
  end

  revision 3


  deprecate! date: "2026-10-24", because: :unmaintained
  disable! date: "2027-04-24", because: :unmaintained

  depends_on "libtiff"

  on_macos do
    depends_on "jpeg-turbo"
  end

  # Fix -flat_namespace being used on Big Sur and later.
  patch do
    file "Patches/libtool/configure-pre-0.4.2.418-big_sur.diff"
    type :unofficial
  end

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    ENV.deparallelize
    args = ["--disable-silent-rules"]
    # Help old config scripts identify arm64 linux
    args << "--build=aarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arm64?
    args << "--build=loongarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arch == :loongarch64

    system "./configure", *args, *std_configure_args
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~C
      #define SPANDSP_EXPOSE_INTERNAL_STRUCTURES
      #include <spandsp.h>

      int main()
      {
        t38_terminal_state_t t38;
        memset(&t38, 0, sizeof(t38));
        return (t38_terminal_init(&t38, 0, NULL, NULL) == NULL) ? 0 : 1;
      }
    C
    system ENV.cc, "test.c", "-L#{lib}", "-lspandsp", "-o", "test"
    system "./test"
  end
end
