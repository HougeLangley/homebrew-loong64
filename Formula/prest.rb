class Prest < Formula
  desc "Instant REST and MCP APIs for PostgreSQL and MySQL, on existing or new databases. CRUD, cu"
  homepage "https://example.org/prest"
  version "2.5.2"
  url "http://127.0.0.1:8080/brew/bottles/prest--2.5.2.loongarch64.bottle.tar.gz"
  sha256 "ae6165bdc2b1d21a0c89de6eafebd9e92cb52aabc4d8c423371e2dd2c774f7df"

  def install
    bin.install "prest"
  end

  test do
    system "#{bin}/prest"
  end
end
