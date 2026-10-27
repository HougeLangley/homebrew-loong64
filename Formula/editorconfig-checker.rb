class Editorconfig-checker < Formula
  desc "Tool to verify that your files are in harmony with your .editorconfig"
  homepage "https://example.org/editorconfig-checker"
  version "4.0.2"
  url "http://127.0.0.1:8080/brew/bottles/editorconfig-checker--4.0.2.loongarch64.bottle.tar.gz"
  sha256 "82fc7d03a508ca2c9dc49624e2abdcd974d98de2f254ed180dbf751f88931e3d"

  def install
    bin.install "editorconfig-checker"
  end

  test do
    system "#{bin}/editorconfig-checker"
  end
end
