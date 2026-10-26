class Lazydocker < Formula
  desc "Terminal UI for docker"
  homepage "https://example.org/lazydocker"
  version "0.25.2"
  url "http://127.0.0.1:8080/brew/bottles/lazydocker--0.25.2.loongarch64.bottle.tar.gz"
  sha256 "f2ce1a6cbbeaa66f72dcdd371623ddcba961e1f8e4d84d0e2ca91fd95736861e"

  def install
    bin.install "lazydocker"
  end

  test do
    system "#{bin}/lazydocker"
  end
end
