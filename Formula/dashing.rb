class Dashing < Formula
  desc "Generate Dash documentation from HTML files"
  homepage "https://example.org/dashing"
  version "0.4.0"
  url "http://127.0.0.1:8080/brew/bottles/dashing--0.4.0.loongarch64.bottle.tar.gz"
  sha256 "70bf77ffb9987f4d61b689beda4fa0d55d837ccc0a6d5bc7f4b4018110d2f047"

  def install
    bin.install "dashing"
  end

  test do
    system "#{bin}/dashing"
  end
end
