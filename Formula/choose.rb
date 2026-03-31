class Choose < Formula
  desc "Human-friendly and fast alternative to cut and (sometimes) awk"
  homepage "https://github.com/theryangeary/choose"
  url "https://github.com/theryangeary/choose/archive/refs/tags/v1.3.7.tar.gz"
  sha256 "6e426dddb5d780fc529a54f37680b5b07123a34b48cd614359b08f10d0fd659d"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    system bin/"choose", "--version"
  end
end
