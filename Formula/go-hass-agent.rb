class Go-hass-agent < Formula
  desc "Native Home Assistant agent for desktop/laptop devices"
  homepage "https://example.org/go-hass-agent"
  version "14.18.0"
  url "http://127.0.0.1:8080/brew/bottles/go-hass-agent--14.18.0.loongarch64.bottle.tar.gz"
  sha256 "ee954fca4557d486c70d0e2ac76370d6868e3c6b3615ab88666e270b899ce823"

  def install
    bin.install "go-hass-agent"
  end

  test do
    system "#{bin}/go-hass-agent"
  end
end
