class Just < Formula
  desc "Command runner"
  homepage "https://github.com/casey/just"
  url "https://github.com/casey/just/archive/refs/tags/1.48.0.tar.gz"
  sha256 "sha256_placeholder"
  license "CC0-1.0"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    system bin/"just", "--version"
  end
end
