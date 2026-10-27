class Docker-volume-backup < Formula
  desc "Backup Docker volumes locally or to any S3, WebDAV, Azure Blob Storage, Dropbox, Google Dr"
  homepage "https://example.org/docker-volume-backup"
  version "2.49.3"
  url "http://127.0.0.1:8080/brew/bottles/docker-volume-backup--2.49.3.loongarch64.bottle.tar.gz"
  sha256 "e13e6b4000591824b7d55ca7228878ab165c23cabf87e8154bf66b54fe7d143e"

  def install
    bin.install "docker-volume-backup"
  end

  test do
    system "#{bin}/docker-volume-backup"
  end
end
