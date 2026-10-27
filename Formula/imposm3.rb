class Imposm3 < Formula
  desc "Imports OpenStreetMap data into PostgreSQL/PostGIS databases"
  homepage "https://example.org/imposm3"
  version "0.14.2"
  url "http://127.0.0.1:8080/brew/bottles/imposm3--0.14.2.loongarch64.bottle.tar.gz"
  sha256 "1a5ac3ad28256e75694c6388abaa7d4938094af0041b9833bcbe66ff6a027453"

  def install
    bin.install "imposm3"
  end

  test do
    system "#{bin}/imposm3"
  end
end
