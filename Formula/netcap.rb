class Netcap < Formula
  desc "A framework for secure and scalable network traffic analysis - https://netcap.io"
  homepage "https://example.org/netcap"
  version "0.13.0"
  url "http://127.0.0.1:8080/brew/bottles/netcap--0.13.0.loongarch64.bottle.tar.gz"
  sha256 "b576dc17f0c1cf90211ab2de696faf98f4d2138ce5a0ad4cb4dc2a907ca3afef"

  def install
    bin.install "netcap"
  end

  test do
    system "#{bin}/netcap"
  end
end
