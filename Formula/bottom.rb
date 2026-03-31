class Bottom < Formula
  desc "Yet another cross-platform graphical process/system monitor"
  homepage "https://github.com/ClementTsang/bottom"
  url "https://github.com/ClementTsang/bottom/archive/refs/tags/0.12.3.tar.gz"
  sha256 "577211b0b9eb4b37fc8a13f7562a7eab1b78ca1bbcb7dc2cf3460de2e50e4e93"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    system bin/"btm", "--version"
  end
end
