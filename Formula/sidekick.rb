class Sidekick < Formula
  desc "Deploy applications to your VPS"
  homepage "https://example.org/sidekick"
  version "0.6.6"
  url "http://127.0.0.1:8080/brew/bottles/sidekick--0.6.6.loongarch64.bottle.tar.gz"
  sha256 "0d8a50db12562f34f4a52b218a42634870ed3ea838b6ae31ec14956e9557cd05"

  def install
    bin.install "sidekick"
  end

  test do
    system "#{bin}/sidekick"
  end
end
