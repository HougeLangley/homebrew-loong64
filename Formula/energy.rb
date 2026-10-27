class Energy < Formula
  desc "CLI is used to initialize the Energy development environment tools"
  homepage "https://example.org/energy"
  version "2.5.6"
  url "http://127.0.0.1:8080/brew/bottles/energy--2.5.6.loongarch64.bottle.tar.gz"
  sha256 "8170f736c49eccd9da2cb5220139051e2b5ac0f4853ee801477b238764db934b"

  def install
    bin.install "energy"
  end

  test do
    system "#{bin}/energy"
  end
end
