class Cloudfox < Formula
  desc "Automating situational awareness for cloud penetration tests."
  homepage "https://example.org/cloudfox"
  version "2.0.5"
  url "http://127.0.0.1:8080/brew/bottles/cloudfox--2.0.5.loongarch64.bottle.tar.gz"
  sha256 "16d63a03e25e09e2d4faff2387d6537749c9b3dbe1a7b408c119014b6a68ca09"

  def install
    bin.install "cloudfox"
  end

  test do
    system "#{bin}/cloudfox"
  end
end
