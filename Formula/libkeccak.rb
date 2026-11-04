class Libkeccak < Formula
  desc "Keccak-family hashing library"
  homepage "https://codeberg.org/maandree/libkeccak"
  url "https://codeberg.org/maandree/libkeccak/archive/1.4.3.tar.gz"
  sha256 "e395732342c9a6cbc22d709434a9d7b40f7b958952e9061ec09ec6d80d7ce83f"
  license "ISC"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "69c78fc0c76e23f8e9446f06bf16fe66ec7aa59c59e0be82433b035d086b4dcc"
  end

  def install
    args = ["PREFIX=#{prefix}"]
    args << "OSCONFIGFILE=macos.mk" if OS.mac?

    system "make", "install", *args
    pkgshare.install %w[.testfile test.c]
  end

  test do
    cp_r pkgshare/".testfile", testpath
    system ENV.cc, pkgshare/"test.c", "-std=c99", "-O3", "-I#{include}", "-L#{lib}", "-lkeccak", "-o", "test"
    system "./test"
  end
end
