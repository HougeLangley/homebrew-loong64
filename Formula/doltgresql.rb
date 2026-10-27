class Doltgresql < Formula
  desc "DoltgreSQL - Version Controlled PostgreSQL"
  homepage "https://example.org/doltgresql"
  version "1.4.0"
  url "http://127.0.0.1:8080/brew/bottles/doltgresql--1.4.0.loongarch64.bottle.tar.gz"
  sha256 "f84ce1a9f84d296289c79a40079eddddc8d2f28a8f50dbd3af1889ac0cc5bcd6"

  def install
    bin.install "doltgresql"
  end

  test do
    system "#{bin}/doltgresql"
  end
end
