class Trippy < Formula
  desc "Network diagnostic tool"
  homepage "https://example.org/trippy"
  version "0.13.0"
  url "http://127.0.0.1:8080/brew/bottles/trippy--0.13.0.loongarch64.bottle.tar.gz"
  sha256 "f6efe56b96393b4779e8d9f3acb3a1d86c0a5a8c3733aab3d6d0aabdc51e10d0"

  def install
    bin.install "trippy"
  end

  test do
    system "#{bin}/trippy"
  end
end
