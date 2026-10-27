class Faas-cli < Formula
  desc "CLI for templating and/or deploying FaaS functions"
  homepage "https://example.org/faas-cli"
  version "0.18.18"
  url "http://127.0.0.1:8080/brew/bottles/faas-cli--0.18.18.loongarch64.bottle.tar.gz"
  sha256 "1e0e5dce4bfdda85736b1e98e0640289dc46f52ea9e0445b2b30f27f864f6275"

  def install
    bin.install "faas-cli"
  end

  test do
    system "#{bin}/faas-cli"
  end
end
