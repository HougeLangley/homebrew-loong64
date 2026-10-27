class Lure < Formula
  desc "The community repository missing from your Linux distro"
  homepage "https://example.org/lure"
  version "0.1.3"
  url "http://127.0.0.1:8080/brew/bottles/lure--0.1.3.loongarch64.bottle.tar.gz"
  sha256 "94a8082e1d2f2c378e7a49e074244e468e7fffaff25f211e6621be206af3f475"

  def install
    bin.install "lure"
  end

  test do
    system "#{bin}/lure"
  end
end
