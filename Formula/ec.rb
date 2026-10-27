class Ec < Formula
  desc "Terminal-native 3-way git mergetool and diff viewer"
  homepage "https://example.org/ec"
  version "0.4.2"
  url "http://127.0.0.1:8080/brew/bottles/ec--0.4.2.loongarch64.bottle.tar.gz"
  sha256 "73bc3ddd3c14c7a0927a2dad2eea4a14b0b68ad75034661c27c79c0f598e5de6"

  def install
    bin.install "ec"
  end

  test do
    system "#{bin}/ec"
  end
end
