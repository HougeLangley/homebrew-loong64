class Geoipupdate < Formula
  desc "Automatic updates of GeoIP2 and GeoIP Legacy databases"
  homepage "https://example.org/geoipupdate"
  version "8.0.0"
  url "http://127.0.0.1:8080/brew/bottles/geoipupdate--8.0.0.loongarch64.bottle.tar.gz"
  sha256 "a6d866ce4808ac9dd04b7086eab77bc1a5571d769e0c55ec64161cc30693d9f0"

  def install
    bin.install "geoipupdate"
  end

  test do
    system "#{bin}/geoipupdate"
  end
end
