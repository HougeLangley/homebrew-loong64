class Readpe < Formula
  desc "PE analysis toolkit"
  homepage "https://github.com/mentebinaria/readpe"
  url "https://github.com/mentebinaria/readpe/archive/refs/tags/v0.85.1.tar.gz"
  sha256 "3218099d94c81488a4b042d86f64a4076835e1f2f2aff8ed4d58f01c20567507"
  license "GPL-2.0-or-later"
  head "https://github.com/mentebinaria/readpe.git", branch: "master"

  bottle do
    rebuild 2
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "d1548af727392616156d60b0ad5a93f0150c5b22b3e30b44ab9562f22c01943f"
  end



  depends_on "openssl@4"

  resource "homebrew-testfile", :test do
    url "https://the.earth.li/~sgtatham/putty/0.78/w64/putty.exe"
    sha256 "fc6f9dbdf4b9f8dd1f5f3a74cb6e55119d3fe2c9db52436e10ba07842e6c3d7c"
  end

  def install
    ENV.deparallelize
    inreplace "lib/libpe/Makefile", "-flat_namespace", ""
    system "make", "prefix=#{prefix}", "CC=#{ENV.cc}"
    system "make", "prefix=#{prefix}", "install"
  end

  test do
    resource("homebrew-testfile").stage do
      assert_match(/Bytes in last page:\s+120/, shell_output("#{bin}/readpe ./putty.exe"))
    end
  end
end
