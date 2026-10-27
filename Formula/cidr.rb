class Cidr < Formula
  desc "CLI to perform various actions on CIDR ranges"
  homepage "https://example.org/cidr"
  version "2.3.0"
  url "http://127.0.0.1:8080/brew/bottles/cidr--2.3.0.loongarch64.bottle.tar.gz"
  sha256 "cb60c14abc897dde8eebab8f86793b778c9236b4447ab1db98ee7ff5fa3121da"

  def install
    bin.install "cidr"
  end

  test do
    system "#{bin}/cidr"
  end
end
