class Sftpgo < Formula
  desc "Full-featured and highly configurable SFTP, HTTP/S, FTP/S and WebDAV server - S3, Google C"
  homepage "https://example.org/sftpgo"
  version "2.7.6"
  url "http://127.0.0.1:8080/brew/bottles/sftpgo--2.7.6.loongarch64.bottle.tar.gz"
  sha256 "c3aa4341970c085ef0a8d3d0692fef5f2ca6cdb73b87ef35a80edaaeb9d0dfce"

  def install
    bin.install "sftpgo"
  end

  test do
    system "#{bin}/sftpgo"
  end
end
