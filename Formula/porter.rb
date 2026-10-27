class Porter < Formula
  desc "App artifacts, tools, configs, and logic packaged as distributable installer"
  homepage "https://example.org/porter"
  version "1.6.1"
  url "http://127.0.0.1:8080/brew/bottles/porter--1.6.1.loongarch64.bottle.tar.gz"
  sha256 "dfda2c8ef6884f42ec33369d1b9b13a248984cdc5dbb468e19d854fe7ce1ddb0"

  def install
    bin.install "porter"
  end

  test do
    system "#{bin}/porter"
  end
end
