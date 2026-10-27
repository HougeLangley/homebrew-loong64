class Gotop < Formula
  desc "Terminal based graphical activity monitor inspired by gtop and vtop"
  homepage "https://example.org/gotop"
  version "4.2.0"
  url "http://127.0.0.1:8080/brew/bottles/gotop--4.2.0.loongarch64.bottle.tar.gz"
  sha256 "6244b27628dda781ae919c4443964a9f6a96c2891d3843df62f1c9851a840ae4"

  def install
    bin.install "gotop"
  end

  test do
    system "#{bin}/gotop"
  end
end
