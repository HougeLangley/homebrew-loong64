class Tkey-ssh-agent < Formula
  desc "SSH agent for use with the TKey security stick"
  homepage "https://example.org/tkey-ssh-agent"
  version "1.1.1"
  url "http://127.0.0.1:8080/brew/bottles/tkey-ssh-agent--1.1.1.loongarch64.bottle.tar.gz"
  sha256 "ef5deb06d758d3166d61360a8f7e283e1ce7600e9ba818929934bc8475103f75"

  def install
    bin.install "tkey-ssh-agent"
  end

  test do
    system "#{bin}/tkey-ssh-agent"
  end
end
