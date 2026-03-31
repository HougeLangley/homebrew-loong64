class Tre < Formula
  desc "Tree command, improved"
  homepage "https://github.com/dduan/tre"
  url "https://github.com/dduan/tre/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "256f7c74ce23de732865c23e7af46d345eb2c8c5ec1320f33f2fd5d8d7c29700"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    system bin/"tre", "--version"
  end
end
