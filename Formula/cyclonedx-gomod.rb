class Cyclonedx-gomod < Formula
  desc "Creates CycloneDX Software Bill of Materials (SBOM) from Go modules"
  homepage "https://example.org/cyclonedx-gomod"
  version "1.12.0"
  url "http://127.0.0.1:8080/brew/bottles/cyclonedx-gomod--1.12.0.loongarch64.bottle.tar.gz"
  sha256 "0b10373af229731efe6354e5f38d8108c4733ed41b32ca0963eb725d1af55ecf"

  def install
    bin.install "cyclonedx-gomod"
  end

  test do
    system "#{bin}/cyclonedx-gomod"
  end
end
