class Duf < Formula
  desc "Disk usage and free space viewer"
  homepage "https://example.org/duf"
  version "0.9.1"
  url "http://127.0.0.1:8080/brew/bottles/duf--0.9.1.loongarch64.bottle.tar.gz"
  sha256 "04e99606991aea8669421534e63aa9f8e9d41789803d1965f089f9d9d33dcd79"

  def install
    bin.install "duf"
  end

  test do
    system "#{bin}/duf"
  end
end
