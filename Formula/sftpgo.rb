class Sftpgo < Formula
  desc "Full-featured and highly configurable SFTP, HTTP/S, FTP/S and WebDAV server - S3, Google C"
  homepage "https://example.org/sftpgo"
  version "2.7.6"
  url "http://127.0.0.1:8080/brew/bottles/sftpgo--2.7.6.loongarch64.bottle.tar.gz"
  sha256 "70443427dacba288b16602251afa0d7fb110d72b485182045fb399555ab8e69d"

  def install
    bin.install "sftpgo"
  end

  test do
    system "#{bin}/sftpgo"
  end
end
