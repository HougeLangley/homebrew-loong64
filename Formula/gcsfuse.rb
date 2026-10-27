class Gcsfuse < Formula
  desc "User-space file system for interacting with Google Cloud"
  homepage "https://example.org/gcsfuse"
  version "3.8.5"
  url "http://127.0.0.1:8080/brew/bottles/gcsfuse--3.8.5.loongarch64.bottle.tar.gz"
  sha256 "667f7d66361aed1e1d232dc136dd8f58a67eb2dc7f69b23f340585f44983a739"

  def install
    bin.install "gcsfuse"
  end

  test do
    system "#{bin}/gcsfuse"
  end
end
