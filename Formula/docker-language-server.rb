class Docker-language-server < Formula
  desc "Language server for Dockerfiles, Compose files, and Bake files"
  homepage "https://example.org/docker-language-server"
  version "0.20.1"
  url "http://127.0.0.1:8080/brew/bottles/docker-language-server--0.20.1.loongarch64.bottle.tar.gz"
  sha256 "021ba454b5bcd912f58e547144d7b7b1b31471ef022475eceb3ae7764f9478ef"

  def install
    bin.install "docker-language-server"
  end

  test do
    system "#{bin}/docker-language-server"
  end
end
