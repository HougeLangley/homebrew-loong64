class Squealer < Formula
  desc "Scans Git repositories or filesystems for secrets in commit histories"
  homepage "https://example.org/squealer"
  version "1.2.12"
  url "http://127.0.0.1:8080/brew/bottles/squealer--1.2.12.loongarch64.bottle.tar.gz"
  sha256 "fd64c5e1a052f3efdaf381a3a8cfaaa8e4340d2f24a7bebc912e81500e7a536d"

  def install
    bin.install "squealer"
  end

  test do
    system "#{bin}/squealer"
  end
end
