class Infracost < Formula
  desc "Cloud cost intelligence for engineers, AI coding agents, and CI/CD 💰📉 Shift FinOps Left!"
  homepage "https://example.org/infracost"
  version "0.10.47"
  url "http://127.0.0.1:8080/brew/bottles/infracost--0.10.47.loongarch64.bottle.tar.gz"
  sha256 "aaf0d805095067538cd654353c0e1f3f847f202d7875e21d9faa980f184d5c76"

  def install
    bin.install "infracost"
  end

  test do
    system "#{bin}/infracost"
  end
end
