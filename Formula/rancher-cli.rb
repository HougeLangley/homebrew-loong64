class Rancher-cli < Formula
  desc "Unified tool to manage your Rancher server"
  homepage "https://example.org/rancher-cli"
  version "2.15.2"
  url "http://127.0.0.1:8080/brew/bottles/rancher-cli--2.15.2.loongarch64.bottle.tar.gz"
  sha256 "2570275c49968b32fa48c3fe647306277a8e8dc37cd6fcc44f4f4140d5bd58f4"

  def install
    bin.install "rancher-cli"
  end

  test do
    system "#{bin}/rancher-cli"
  end
end
