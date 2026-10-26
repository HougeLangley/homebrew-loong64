class Choose < Formula
  desc "Human-friendly and fast alternative to cut and awk"
  homepage "https://example.org/choose"
  version "1.3.7"
  url "http://127.0.0.1:8080/brew/bottles/choose--1.3.7.loongarch64.bottle.tar.gz"
  sha256 "471669f5c29f4b949ab817fe03142301a522be30b4880ce7dc37b54693940dce"

  def install
    bin.install "choose"
  end

  test do
    system "#{bin}/choose"
  end
end
