class Transfer.sh < Formula
  desc "Easy and fast file sharing from the command-line."
  homepage "https://example.org/transfer.sh"
  version "1.6.1"
  url "http://127.0.0.1:8080/brew/bottles/transfer.sh--1.6.1.loongarch64.bottle.tar.gz"
  sha256 "a8cddfb50bf52841dcc58e9631a86ad10775b4883b54729c4898dac19561c40a"

  def install
    bin.install "transfer.sh"
  end

  test do
    system "#{bin}/transfer.sh"
  end
end
