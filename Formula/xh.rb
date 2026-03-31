class Xh < Formula
  desc "Friendly and fast tool for sending HTTP requests"
  homepage "https://github.com/ducaale/xh"
  url "https://github.com/ducaale/xh/archive/refs/tags/v0.25.0.tar.gz"
  sha256 "5d4b291575a36f155f0148c17dc1ff4f5b9c06f0e6b7a282e8561b3214a4f90f"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    system bin/"xh", "--version"
  end
end
