class Gitui < Formula
  desc "Blazing fast terminal-ui for git written in rust"
  homepage "https://github.com/extrawurst/gitui"
  url "https://github.com/extrawurst/gitui/archive/refs/tags/v0.28.1.tar.gz"
  sha256 "f46b15085c5ddbbadb9ee4b9e1e2dca9d85a2e4f52a1c0f2e0598c723d8cabb5"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    system bin/"gitui", "--version"
  end
end
