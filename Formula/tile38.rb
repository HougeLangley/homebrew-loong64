class Tile38 < Formula
  desc "In-memory geolocation data store, spatial index, and realtime geofence"
  homepage "https://example.org/tile38"
  version "1.38.0"
  url "http://127.0.0.1:8080/brew/bottles/tile38--1.38.0.loongarch64.bottle.tar.gz"
  sha256 "019edcd1d5f486434a026a1081d4a2d676480b06440544c4db3dc01b57fce7a5"

  def install
    bin.install "tile38"
  end

  test do
    system "#{bin}/tile38"
  end
end
