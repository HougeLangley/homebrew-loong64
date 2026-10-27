class Berglas < Formula
  desc "Tool for managing secrets on Google Cloud"
  homepage "https://example.org/berglas"
  version "2.0.18"
  url "http://127.0.0.1:8080/brew/bottles/berglas--2.0.18.loongarch64.bottle.tar.gz"
  sha256 "bdc45330fe5ea6ec4b2657f6bd5f427278da7f99eb5f4d6206c7eec44c1af76d"

  def install
    bin.install "berglas"
  end

  test do
    system "#{bin}/berglas"
  end
end
