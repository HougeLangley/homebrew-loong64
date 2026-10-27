class Loggo < Formula
  desc "A powerful terminal app for structured log streaming"
  homepage "https://example.org/loggo"
  version "0.3.26"
  url "http://127.0.0.1:8080/brew/bottles/loggo--0.3.26.loongarch64.bottle.tar.gz"
  sha256 "16f9441cd39bca4bb6744c4a4ee0d1e42164f05a7f30cbafc02eeba4f482a536"

  def install
    bin.install "loggo"
  end

  test do
    system "#{bin}/loggo"
  end
end
