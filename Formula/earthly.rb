class Earthly < Formula
  desc "Build automation tool for the container era"
  homepage "https://example.org/earthly"
  version "0.8.16"
  url "http://127.0.0.1:8080/brew/bottles/earthly--0.8.16.loongarch64.bottle.tar.gz"
  sha256 "eb5b0659c81dcd3c392fc98082d9b4183537d2f6bf6d1d2b5000ca94acdc0e68"

  def install
    bin.install "earthly"
  end

  test do
    system "#{bin}/earthly"
  end
end
