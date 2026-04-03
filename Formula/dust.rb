class Dust < Formula
  desc "More intuitive version of du in rust"
  homepage "https://github.com/bootandy/dust"
  url "https://github.com/bootandy/dust/archive/refs/tags/v1.2.4.tar.gz"
  sha256 "2f6768534bd01727234e67f1dd3754c9547aa18c715f6ee52094e881ebac50e3"
  license "Apache-2.0"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    system bin/"dust", "--version"
  end
end
