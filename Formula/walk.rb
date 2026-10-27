class Walk < Formula
  desc "Terminal file manager"
  homepage "https://example.org/walk"
  version "1.13.0"
  url "http://127.0.0.1:8080/brew/bottles/walk--1.13.0.loongarch64.bottle.tar.gz"
  sha256 "4063030e1da35ba949d4856ad4a57292e9f79a0ce79598e37351387c8b4658c4"

  def install
    bin.install "walk"
  end

  test do
    system "#{bin}/walk"
  end
end
