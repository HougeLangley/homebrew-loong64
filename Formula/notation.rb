class Notation < Formula
  desc "CLI tool to sign and verify OCI artifacts and container images"
  homepage "https://example.org/notation"
  version "1.3.2"
  url "http://127.0.0.1:8080/brew/bottles/notation--1.3.2.loongarch64.bottle.tar.gz"
  sha256 "255145c4afd606a7966ba39abf0bcc411d25a1e3a59d67bf208e8fee2fd79e8e"

  def install
    bin.install "notation"
  end

  test do
    system "#{bin}/notation"
  end
end
