class Skm < Formula
  desc "Simple and powerful SSH keys manager"
  homepage "https://example.org/skm"
  version "0.9.3"
  url "http://127.0.0.1:8080/brew/bottles/skm--0.9.3.loongarch64.bottle.tar.gz"
  sha256 "d1394a3761a835199f2479bfafb78d83c5e51c150fbd8b656f44986ed1e28136"

  def install
    bin.install "skm"
  end

  test do
    system "#{bin}/skm"
  end
end
