class Trzsz-ssh < Formula
  desc "Highly OpenSSH-compatible client with extended features"
  homepage "https://example.org/trzsz-ssh"
  version "0.1.27"
  url "http://127.0.0.1:8080/brew/bottles/trzsz-ssh--0.1.27.loongarch64.bottle.tar.gz"
  sha256 "08510f74c22dfce368d096b8c364aacccef55a69dac13f96a0a86bc3e664f086"

  def install
    bin.install "trzsz-ssh"
  end

  test do
    system "#{bin}/trzsz-ssh"
  end
end
