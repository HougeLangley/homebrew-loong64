class Kbld < Formula
  desc "Tool for building and pushing container images in development workflows"
  homepage "https://example.org/kbld"
  version "0.49.2"
  url "http://127.0.0.1:8080/brew/bottles/kbld--0.49.2.loongarch64.bottle.tar.gz"
  sha256 "b669a060cb1b1406db38d54ddcd0ef51884559e5c8796d5664b9452aacc91860"

  def install
    bin.install "kbld"
  end

  test do
    system "#{bin}/kbld"
  end
end
