class Codemap < Formula
  desc "a project brain for your AI. Give LLMs instant architectural context without burning token"
  homepage "https://example.org/codemap"
  version "4.6.0"
  url "http://127.0.0.1:8080/brew/bottles/codemap--4.6.0.loongarch64.bottle.tar.gz"
  sha256 "d6d8b2d0daf749bfc1ab511af12cbce6e36c3b305b9f5c25ea8e567ce600cc33"

  def install
    bin.install "codemap"
  end

  test do
    system "#{bin}/codemap"
  end
end
