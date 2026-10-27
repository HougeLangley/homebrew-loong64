class Tilt < Formula
  desc "Define your dev environment as code. For microservice apps on Kubernetes."
  homepage "https://example.org/tilt"
  version "0.37.8"
  url "http://127.0.0.1:8080/brew/bottles/tilt--0.37.8.loongarch64.bottle.tar.gz"
  sha256 "e0b4c06ca4a882036cf7303ce4af4d41f1a75676b5c6eae8ce1a0ce86082c327"

  def install
    bin.install "tilt"
  end

  test do
    system "#{bin}/tilt"
  end
end
