class Botkube < Formula
  desc "An app that helps you monitor your Kubernetes cluster, debug critical deployments & gives "
  homepage "https://example.org/botkube"
  version "1.14.0"
  url "http://127.0.0.1:8080/brew/bottles/botkube--1.14.0.loongarch64.bottle.tar.gz"
  sha256 "ee18c322bbd7fdba06a3efad0dfda951aa4ba2409aa69a385f869668959afc11"

  def install
    bin.install "botkube"
  end

  test do
    system "#{bin}/botkube"
  end
end
