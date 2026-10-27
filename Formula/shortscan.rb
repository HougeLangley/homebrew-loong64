class Shortscan < Formula
  desc "An IIS short filename enumeration tool"
  homepage "https://example.org/shortscan"
  version "0.9.2"
  url "http://127.0.0.1:8080/brew/bottles/shortscan--0.9.2.loongarch64.bottle.tar.gz"
  sha256 "da2793ca6fbfb114f1ba2482cea31d16cf2b6326ee4e578dfe795d1a5190e942"

  def install
    bin.install "shortscan"
  end

  test do
    system "#{bin}/shortscan"
  end
end
