class Viu < Formula
  desc "Simple terminal image viewer"
  homepage "https://github.com/atanunq/viu"
  url "https://github.com/atanunq/viu/archive/refs/tags/v1.6.1.tar.gz"
  sha256 "sha256_placeholder"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    system bin/"viu", "--version"
  end
end
