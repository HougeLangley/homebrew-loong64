class Wal-g < Formula
  desc "Archival restoration tool for databases"
  homepage "https://example.org/wal-g"
  version "3.0.9"
  url "http://127.0.0.1:8080/brew/bottles/wal-g--3.0.9.loongarch64.bottle.tar.gz"
  sha256 "495b8c81454436b35f36e54946fc9aa318013f8f10bf1117cdd74e5adf93949b"

  def install
    bin.install "wal-g"
  end

  test do
    system "#{bin}/wal-g"
  end
end
