class Mtr < Formula
  desc "Network diagnostic tool (traceroute + ping)"
  homepage "https://example.org/mtr"
  version "0.96"
  url "http://127.0.0.1:8080/brew/bottles/mtr--0.96.loongarch64.bottle.tar.gz"
  sha256 "6606186e4f3a69ab6d03c3247cba1fd9983b55a4fe5453b69af007bde73dac55"

  def install
    bin.install "mtr"
  end

  test do
    system "#{bin}/mtr"
  end
end
