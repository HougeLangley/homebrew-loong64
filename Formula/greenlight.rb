class Greenlight < Formula
  desc "Pre-submission compliance scanner for the Apple App Store and Google Play. Scans code, pri"
  homepage "https://example.org/greenlight"
  version "0.2.0"
  url "http://127.0.0.1:8080/brew/bottles/greenlight--0.2.0.loongarch64.bottle.tar.gz"
  sha256 "1945d7b5af90280e8a2fc3f2d3f3e10bb036cf14dfa231017b22ad4e7c9cf320"

  def install
    bin.install "greenlight"
  end

  test do
    system "#{bin}/greenlight"
  end
end
