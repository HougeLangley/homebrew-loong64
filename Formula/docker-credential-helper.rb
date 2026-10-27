class Docker-credential-helper < Formula
  desc "Platform keystore credential helper for Docker"
  homepage "https://example.org/docker-credential-helper"
  version "0.9.12"
  url "http://127.0.0.1:8080/brew/bottles/docker-credential-helper--0.9.12.loongarch64.bottle.tar.gz"
  sha256 "001be52e933e667c46eda722fec5aa4d6715208aaaf728b7eca1eadc1a655e40"

  def install
    bin.install "docker-credential-helper"
  end

  test do
    system "#{bin}/docker-credential-helper"
  end
end
