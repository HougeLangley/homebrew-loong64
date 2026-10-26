class Helix < Formula
  desc "Post-modern text editor"
  homepage "https://example.org/helix"
  version "25.07.1"
  url "http://127.0.0.1:8080/brew/bottles/helix--25.07.1.loongarch64.bottle.tar.gz"
  sha256 "c5d634f5c8fa78939c4f6f036fff0e051865ef01691e7f69a8008e0073ee2f5e"

  def install
    bin.install "helix"
  end

  test do
    system "#{bin}/helix"
  end
end
