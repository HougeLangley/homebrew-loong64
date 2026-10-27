class Subjack < Formula
  desc "DNS Takeover tool written in Go"
  homepage "https://example.org/subjack"
  version "3.1.0"
  url "http://127.0.0.1:8080/brew/bottles/subjack--3.1.0.loongarch64.bottle.tar.gz"
  sha256 "e26f2a476918c36172e3e5a14c267d0874c266ef0ab907aa6ce46898e7e6c7dd"

  def install
    bin.install "subjack"
  end

  test do
    system "#{bin}/subjack"
  end
end
