class IsaL < Formula
  desc "Intelligent Storage Acceleration Library"
  homepage "https://github.com/intel/isa-l"
  url "https://github.com/intel/isa-l/archive/refs/tags/v2.32.1.tar.gz"
  sha256 "d9f7179ab0e14a3db9b610fac22793854a1435e8423ec9ce07f4cbedc5f92f5e"
  license "BSD-3-Clause"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "a4ed958d8627a6283d898de38f9e88f47defad008806082c21db48af934e52e3"
  end


  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  on_intel do
    depends_on "nasm" => :build
  end

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "./autogen.sh"
    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--disable-silent-rules", *std_configure_args
    system "make"
    system "make", "install"
    pkgshare.install "examples"
  end

  test do
    cp pkgshare/"examples/ec/ec_simple_example.c", testpath
    inreplace "ec_simple_example.c", "erasure_code.h", "isa-l.h"
    system ENV.cc, "ec_simple_example.c", "-L#{lib}", "-lisal", "-o", "test"
    assert_match "Pass", shell_output("./test")
  end
end
