class Dokku < Formula
  desc "A docker-powered PaaS that helps you build and manage the lifecycle of applications"
  homepage "https://example.org/dokku"
  version "0.38.32"
  url "http://127.0.0.1:8080/brew/bottles/dokku--0.38.32.loongarch64.bottle.tar.gz"
  sha256 "f938a802f6cb159ebb119f6d7ac9c95e78ed4dba38047790225ac0cd4559fccf"

  def install
    bin.install "dokku"
  end

  test do
    system "#{bin}/dokku"
  end
end
