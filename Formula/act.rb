class Act < Formula
  desc "Run your GitHub Actions locally 🚀"
  homepage "https://example.org/act"
  version "0.2.89"
  url "http://127.0.0.1:8080/brew/bottles/act--0.2.89.loongarch64.bottle.tar.gz"
  sha256 "83ab35debd65f85c1f01234f73c7145f7c3d8c65cbd87048a975d39ee4b8ba29"

  def install
    bin.install "act"
  end

  test do
    system "#{bin}/act"
  end
end
