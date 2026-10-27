class Hectane < Formula
  desc "Lightweight SMTP client written in Go"
  homepage "https://example.org/hectane"
  version "0.3.2"
  url "http://127.0.0.1:8080/brew/bottles/hectane--0.3.2.loongarch64.bottle.tar.gz"
  sha256 "0356498d798e4fa0c779ba123f3e3b066a945eb2781747a587aed0e2568f0416"

  def install
    bin.install "hectane"
  end

  test do
    system "#{bin}/hectane"
  end
end
