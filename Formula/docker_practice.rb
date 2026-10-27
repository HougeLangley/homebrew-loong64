class Docker_practice < Formula
  desc "最新Docker容器技术，从真实案例中学习最佳实践！/ Learn and understand Docker&Container technologies, with real "
  homepage "https://example.org/docker_practice"
  version "1.11.0"
  url "http://127.0.0.1:8080/brew/bottles/docker_practice--1.11.0.loongarch64.bottle.tar.gz"
  sha256 "87923b0abcb76073d18162b4314390ccc3ed7ba660b7dd50345e861648e37f36"

  def install
    bin.install "docker_practice"
  end

  test do
    system "#{bin}/docker_practice"
  end
end
