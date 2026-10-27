class Etcd < Formula
  desc "Distributed reliable key-value store for the most critical data of a distributed system"
  homepage "https://example.org/etcd"
  version "3.7.3"
  url "http://127.0.0.1:8080/brew/bottles/etcd--3.7.3.loongarch64.bottle.tar.gz"
  sha256 "d8f724130cb95ea9ec74fea295a74988e21d08c74aca45916c953493350f7d79"

  def install
    bin.install "etcd"
  end

  test do
    system "#{bin}/etcd"
  end
end
