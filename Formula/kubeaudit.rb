class Kubeaudit < Formula
  desc "Helps audit your Kubernetes clusters against common security controls"
  homepage "https://example.org/kubeaudit"
  version "0.22.2"
  url "http://127.0.0.1:8080/brew/bottles/kubeaudit--0.22.2.loongarch64.bottle.tar.gz"
  sha256 "914483a024333a6e0848a5523b54698af7113576a5d26d9845ac9ecf169b3ef6"

  def install
    bin.install "kubeaudit"
  end

  test do
    system "#{bin}/kubeaudit"
  end
end
