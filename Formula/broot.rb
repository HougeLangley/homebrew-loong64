class Broot < Formula
  desc "New way to see and navigate directory trees"
  homepage "https://dystroy.org/broot/"
  url "https://github.com/Canop/broot/archive/refs/tags/v1.56.2.tar.gz"
  sha256 "ddee3cb62f989c96c6d4238aad12d1a1e4286b6b9c99a840daacd2b548fbcd41"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    system bin/"broot", "--version"
  end
end
