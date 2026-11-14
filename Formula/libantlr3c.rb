class Libantlr3c < Formula
  desc "ANTLRv3 parsing library for C"
  homepage "https://www.antlr3.org/"
  url "https://github.com/antlr/antlr3/archive/refs/tags/3.5.3.tar.gz"
  sha256 "a0892bcf164573d539b930e57a87ea45333141863a0dd3a49e5d8c919c8a58ab"
  license "BSD-3-Clause"

  livecheck do
    url :stable
    regex(/^(?:(?:antlr|release)[._-])?v?(\d+(?:\.\d+)+)$/i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "d552347585e321adbbbe25076a43e028ab979d0d9663e394a013d5166f5ed537"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  def install
    cd "runtime/C" do
      args = %w[
        --disable-antlrdebug
        --disable-debuginfo
      ]
      # LoongArch GCC rejects both -m32 and -m64; LP64 is already the default.
      args << "--enable-64bit" unless OS.linux? && Hardware::CPU.arch == :loongarch64
      args << "--disable-abiflags" if OS.linux? && (Hardware::CPU.arm? || Hardware::CPU.arch == :loongarch64)

      system "autoreconf", "--force", "--install", "--verbose"
      system "./configure", *args, *std_configure_args.reject { |s| s["--disable-debug"] }
      system "make", "install"
    end
  end

  test do
    (testpath/"hello.c").write <<~C
      #include <antlr3.h>
      int main() {
        if (0) {
          antlr3GenericSetupStream(NULL);
        }
        return 0;
      }
    C
    system ENV.cc, "hello.c", "-L#{lib}", "-lantlr3c", "-o", "hello", "-O0"
    system testpath/"hello"
  end
end
