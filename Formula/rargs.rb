class Rargs < Formula
  desc "xargs + awk with pattern matching support"
  homepage "https://github.com/lotabout/rargs"
  url "https://github.com/lotabout/rargs/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "sha256_placeholder"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    system bin/"rargs", "--version"
  end
end
