class Archiver < Formula
  desc "Cross-platform, multi-format archive utility"
  homepage "https://example.org/archiver"
  version "3.5.1"
  url "http://127.0.0.1:8080/brew/bottles/archiver--3.5.1.loongarch64.bottle.tar.gz"
  sha256 "8e0db53fc16c43e0af0831d5070a1cc303f1502eddc2ce1f264b3838c3c1ee96"

  def install
    bin.install "archiver"
  end

  test do
    system "#{bin}/archiver"
  end
end
