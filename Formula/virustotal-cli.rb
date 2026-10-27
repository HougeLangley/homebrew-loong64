class Virustotal-cli < Formula
  desc "Command-line interface for VirusTotal"
  homepage "https://example.org/virustotal-cli"
  version "1.3.1"
  url "http://127.0.0.1:8080/brew/bottles/virustotal-cli--1.3.1.loongarch64.bottle.tar.gz"
  sha256 "4b7555ad4fc0f196d3e59577bd1858fc30eadbc3d317d871bff20e4dc4ce3c33"

  def install
    bin.install "virustotal-cli"
  end

  test do
    system "#{bin}/virustotal-cli"
  end
end
