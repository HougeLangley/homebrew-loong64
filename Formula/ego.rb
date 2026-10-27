class Ego < Formula
  desc "A simple and component-based microservice kit for go. 一个简单的基于组件的 Go 微服务套件。"
  homepage "https://example.org/ego"
  version "1.2.7"
  url "http://127.0.0.1:8080/brew/bottles/ego--1.2.7.loongarch64.bottle.tar.gz"
  sha256 "f69e4dbb53b30325a44a4336a0e76ca960ea5506456ef4b8607762220fd5ed47"

  def install
    bin.install "ego"
  end

  test do
    system "#{bin}/ego"
  end
end
