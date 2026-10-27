class Atlantis < Formula
  desc "Terraform Pull Request Automation"
  homepage "https://example.org/atlantis"
  version "0.49.0"
  url "http://127.0.0.1:8080/brew/bottles/atlantis--0.49.0.loongarch64.bottle.tar.gz"
  sha256 "9c7853abfe2406e60e2fc7d20dfe4edb426d658bfe31f3be0ade49de5767a66a"

  def install
    bin.install "atlantis"
  end

  test do
    system "#{bin}/atlantis"
  end
end
