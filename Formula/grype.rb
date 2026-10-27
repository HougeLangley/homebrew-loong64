class Grype < Formula
  desc "A vulnerability scanner for container images and filesystems"
  homepage "https://example.org/grype"
  version "0.121.0"
  url "http://127.0.0.1:8080/brew/bottles/grype--0.121.0.loongarch64.bottle.tar.gz"
  sha256 "6e9d8a034ed0d49954bd4765217d0c6b34c945ee730c6c8ff5ef445e4941348f"

  def install
    bin.install "grype"
  end

  test do
    system "#{bin}/grype"
  end
end
