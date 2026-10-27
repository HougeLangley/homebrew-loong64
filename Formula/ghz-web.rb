class Ghz-web < Formula
  desc "Web interface for ghz"
  homepage "https://example.org/ghz-web"
  version "0.121.0"
  url "http://127.0.0.1:8080/brew/bottles/ghz-web--0.121.0.loongarch64.bottle.tar.gz"
  sha256 "2bcc68f4e0c0ab1ce1eb1b64bae5639bd2d2a4f753a20098e638d316bcbbbc18"

  def install
    bin.install "ghz-web"
  end

  test do
    system "#{bin}/ghz-web"
  end
end
