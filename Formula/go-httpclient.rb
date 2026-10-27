class Go-httpclient < Formula
  desc "Advanced HTTP client for golang"
  homepage "https://example.org/go-httpclient"
  version "0.7.1"
  url "http://127.0.0.1:8080/brew/bottles/go-httpclient--0.7.1.loongarch64.bottle.tar.gz"
  sha256 "d282c3d65a3683bc3e6bf671ab67a9db1b4a2cea844e75010fd393c4acb0b2aa"

  def install
    bin.install "go-httpclient"
  end

  test do
    system "#{bin}/go-httpclient"
  end
end
