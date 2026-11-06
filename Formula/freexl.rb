class Freexl < Formula
  desc "Library to extract data from Excel .xls files"
  homepage "https://www.gaia-gis.it/fossil/freexl/index"
  url "https://www.gaia-gis.it/gaia-sins/freexl-sources/freexl-2.0.0.tar.gz"
  sha256 "176705f1de58ab7c1eebbf5c6de46ab76fcd8b856508dbd28f5648f7c6e1a7f0"
  license any_of: ["MPL-1.1", "GPL-2.0-or-later", "LGPL-2.1-or-later"]

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "4542b637db807a3d271b8621702f50e8fcfe9eb25b8e2da0957504aa0c71ffc7"
  end

  livecheck do
    url :homepage
    regex(%r{current version is <b>v?(\d+(?:\.\d+)+)</b>}i)
  end


  depends_on "minizip"

  uses_from_macos "expat"

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
    args << "--build=aarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arm64?
    args << "--build=loongarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arch == :loongarch64

    system "./configure", *args, *std_configure_args
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <stdio.h>
      #include "freexl.h"

      int main()
      {
          printf("%s", freexl_version());
          return 0;
      }
    C
    system ENV.cc, "test.c", "-L#{lib}", "-lfreexl", "-o", "test"
    assert_equal version.to_s, shell_output("./test")
  end
end
