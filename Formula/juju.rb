class Juju < Formula
  desc "Orchestration engine that enables the deployment, integration and lifecycle management of "
  homepage "https://example.org/juju"
  version "4.0.16"
  url "http://127.0.0.1:8080/brew/bottles/juju--4.0.16.loongarch64.bottle.tar.gz"
  sha256 "021ea65ba9435afca7655f7363380e33184826f6db12dfe092e2592721a779fc"

  def install
    bin.install "juju"
  end

  test do
    system "#{bin}/juju"
  end
end
