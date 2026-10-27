class Taskctl < Formula
  desc "Concurrent task runner, developer's routine tasks automation toolkit. Simple modern altern"
  homepage "https://example.org/taskctl"
  version "1.4.2"
  url "http://127.0.0.1:8080/brew/bottles/taskctl--1.4.2.loongarch64.bottle.tar.gz"
  sha256 "e6bbd244e2161fb1ddd8583387eb356cb396d2e5755c84c115e330096a5b5b4a"

  def install
    bin.install "taskctl"
  end

  test do
    system "#{bin}/taskctl"
  end
end
