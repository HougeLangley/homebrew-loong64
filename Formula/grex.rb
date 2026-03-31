class Grex < Formula
  desc "Command-line tool for generating regular expressions"
  homepage "https://github.com/pemistahl/grex"
  url "https://github.com/pemistahl/grex/archive/refs/tags/v1.4.6.tar.gz"
  sha256 "c959a5c19611c14f0f89c5514ed4c77a63e3db130c56d28168287fd6b3813250"
  license "Apache-2.0"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    system bin/"grex", "--version"
  end
end
