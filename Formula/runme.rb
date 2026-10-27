class Runme < Formula
  desc "DevOps Notebooks Built with Markdown"
  homepage "https://example.org/runme"
  version "3.17.6"
  url "http://127.0.0.1:8080/brew/bottles/runme--3.17.6.loongarch64.bottle.tar.gz"
  sha256 "36bb0d7a31693f81111f882ec3c72cab061d5a0fd408b51ee8a5ef37ca81232f"

  def install
    bin.install "runme"
  end

  test do
    system "#{bin}/runme"
  end
end
