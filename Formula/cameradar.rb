class Cameradar < Formula
  desc "Cameradar hacks its way into RTSP videosurveillance cameras"
  homepage "https://example.org/cameradar"
  version "6.2.1"
  url "http://127.0.0.1:8080/brew/bottles/cameradar--6.2.1.loongarch64.bottle.tar.gz"
  sha256 "91edfc4538415330eced674138b2393f93134c30d00dfb0f59923e54284ac963"

  def install
    bin.install "cameradar"
  end

  test do
    system "#{bin}/cameradar"
  end
end
