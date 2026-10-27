class Reader < Formula
  desc "reader is for your command line what the “readability” view is for modern browsers: A ligh"
  homepage "https://example.org/reader"
  version "0.6.1"
  url "http://127.0.0.1:8080/brew/bottles/reader--0.6.1.loongarch64.bottle.tar.gz"
  sha256 "b1bd2d38cc5e939e82da2e8c3f39a7d20465934e1431d537ae21bb6c4a990bd0"

  def install
    bin.install "reader"
  end

  test do
    system "#{bin}/reader"
  end
end
