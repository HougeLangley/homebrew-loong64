class Formae < Formula
  desc "Open-source Infrastructure As Code that starts from what already runs. formae discovers yo"
  homepage "https://example.org/formae"
  version "0.90.5"
  url "http://127.0.0.1:8080/brew/bottles/formae--0.90.5.loongarch64.bottle.tar.gz"
  sha256 "39f7523a1704c3b691ab214119a4af4f55916bd96f0b1f2c46d38c6c406615c9"

  def install
    bin.install "formae"
  end

  test do
    system "#{bin}/formae"
  end
end
