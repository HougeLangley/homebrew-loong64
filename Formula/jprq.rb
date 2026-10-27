class Jprq < Formula
  desc "Join Public Router, Quickly"
  homepage "https://example.org/jprq"
  version "desktop-v1.0.4"
  url "http://127.0.0.1:8080/brew/bottles/jprq--desktop-v1.0.4.loongarch64.bottle.tar.gz"
  sha256 "77f3a4d35be5212f1379d17039e05639e355de52e21675ede5ad2f72bf69b9e6"

  def install
    bin.install "jprq"
  end

  test do
    system "#{bin}/jprq"
  end
end
