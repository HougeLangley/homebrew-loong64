class Testkube < Formula
  desc "☸️ The Open Testing Platform for AI-Driven Engineering Teams"
  homepage "https://example.org/testkube"
  version "2.14.0"
  url "http://127.0.0.1:8080/brew/bottles/testkube--2.14.0.loongarch64.bottle.tar.gz"
  sha256 "aff403b8ef23f04071a1bd28a1559c06fa297652be9d2355a1b3378de104523e"

  def install
    bin.install "testkube"
  end

  test do
    system "#{bin}/testkube"
  end
end
