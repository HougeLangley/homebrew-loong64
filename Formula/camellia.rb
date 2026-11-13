class Camellia < Formula
  desc "Image Processing & Computer Vision library written in C"
  homepage "https://camellia.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/camellia/Unix_Linux%20Distribution/v2.7.0/CamelliaLib-2.7.0.tar.gz"
  sha256 "a3192c350f7124d25f31c43aa17e23d9fa6c886f80459cba15b6257646b2f3d2"
  license "BSD-3-Clause"

  livecheck do
    url :stable
    regex(%r{url=.*?/CamelliaLib[._-]v?(\d+(?:\.\d+)+)\.t}i)
  end


  deny_network_access!

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "36797ad790e3dd4fdcbe22c6803a6059a745c568040968084a9829f2572f3b9a"
  end

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}", "dist/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    # Fix missing include - https://sourceforge.net/p/camellia/bugs/1/
    # cam_demo_cpp.cpp:212:52: error: ‘sprintf’ was not declared in this scope
    if OS.linux?
      inreplace "cam_demo_cpp.cpp",
                "#include <stdlib.h>\r\n",
                "#include <stdlib.h>\r\n#include <stdio.h>\r\n"
    end

    args = []
    # Help old config scripts identify arm64 linux
    args << "--build=aarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    args << "--build=loongarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arch == :loongarch64

    system "./configure", *args, *std_configure_args
    system "make", "install"
  end

  test do
    (testpath/"test.cpp").write <<~CPP
      #include "camellia.h"
      int main() {
        CamImage image; // CamImage is an internal structure of Camellia
        return 0;
      }
    CPP

    system ENV.cxx, "test.cpp", "-I#{include}", "-L#{lib}", "-lCamellia", "-o", "test"
    system "./test"
  end
end
