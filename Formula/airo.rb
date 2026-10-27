class Airo < Formula
  desc "Deploy your projects from local to your production VPS."
  homepage "https://example.org/airo"
  version "0.0.1"
  url "http://127.0.0.1:8080/brew/bottles/airo--0.0.1.loongarch64.bottle.tar.gz"
  sha256 "8ee669ee0708a861e162a053b0a6508c3702e8b888955543088ad7e0bfa546c6"

  def install
    bin.install "airo"
  end

  test do
    system "#{bin}/airo"
  end
end
