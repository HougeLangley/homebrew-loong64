class Gping < Formula
  desc "Ping, but with a graph"
  homepage "https://github.com/orf/gping"
  url "https://github.com/orf/gping/archive/refs/tags/gping-v1.20.1.tar.gz"
  sha256 "e969933497fc4169ed4fe67a5a129f23864ba54489e23c7bdf0a5e2e9c103b35"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    system bin/"gping", "--version"
  end
end
