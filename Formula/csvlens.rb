class Csvlens < Formula
  desc "Command line CSV file viewer"
  homepage "https://github.com/YS-L/csvlens"
  url "https://github.com/YS-L/csvlens/archive/refs/tags/v0.15.1.tar.gz"
  sha256 "sha256_placeholder"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    system bin/"csvlens", "--version"
  end
end
