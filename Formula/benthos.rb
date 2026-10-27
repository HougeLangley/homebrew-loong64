class Benthos < Formula
  desc "Stream processor for mundane tasks written in Go"
  homepage "https://example.org/benthos"
  version "4.84.0"
  url "http://127.0.0.1:8080/brew/bottles/benthos--4.84.0.loongarch64.bottle.tar.gz"
  sha256 "6c8f4637f9751f8a57019ae99d540d0f448d189a25108fc09528edd187ccbe02"

  def install
    bin.install "benthos"
  end

  test do
    system "#{bin}/benthos"
  end
end
