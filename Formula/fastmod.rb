class Fastmod < Formula
  desc "Fast partial replacement for codemod"
  homepage "https://github.com/facebookincubator/fastmod"
  url "https://github.com/facebookincubator/fastmod/archive/refs/tags/v0.4.4.tar.gz"
  sha256 "sha256_placeholder"
  license "Apache-2.0"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    system bin/"fastmod", "--version"
  end
end
