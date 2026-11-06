class Libquantum < Formula
  desc "C library for the simulation of quantum mechanics"
  homepage "http://www.libquantum.de/"
  url "https://cdn.netbsd.org/pub/pkgsrc/distfiles/libquantum-1.0.0.tar.gz"
  mirror "http://www.libquantum.de/files/libquantum-1.0.0.tar.gz"
  sha256 "b0f1a5ec9768457ac9835bd52c3017d279ac99cc0dffe6ce2adf8ac762997b2c"
  license "GPL-3.0-or-later"
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "d6f47d396e07e0e2fea6d7a0ad2b28b46c7316e0d60aa77545aa4fa48fd15e65"
  end

  version_scheme 1

  livecheck do
    url "http://www.libquantum.de/downloads"
    regex(/href=.*?libquantum[._-]v?(\d+\.[02468](?:\.\d+)*)\.t/i)
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
    (testpath/"qtest.c").write <<~C
      #include <stdio.h>
      #include <stdlib.h>
      #include <time.h>
      #include <quantum.h>

      int main ()
      {
        quantum_reg reg;
        int result;
        srand(time(0));
        reg = quantum_new_qureg(0, 1);
        quantum_hadamard(0, &reg);
        result = quantum_bmeasure(0, &reg);
        printf("The Quantum RNG returned %i!\\n", result);
        return 0;
      }
    C
    args = [
      "-O3",
      "-L#{lib}",
      "-lquantum",
    ]
    args << "-fopenmp" if OS.linux?
    system ENV.cc, "qtest.c", *args, "-o", "qtest"
    system "./qtest"
  end
end
