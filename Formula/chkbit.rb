class Chkbit < Formula
  desc "Check your files for data corruption"
  homepage "https://example.org/chkbit"
  version "6.6.0"
  url "http://127.0.0.1:8080/brew/bottles/chkbit--6.6.0.loongarch64.bottle.tar.gz"
  sha256 "27b80765e821544e9ac697acc9bc1794242d7b9d9a202bfa3117281824d14e47"

  def install
    bin.install "chkbit"
  end

  test do
    system "#{bin}/chkbit"
  end
end
