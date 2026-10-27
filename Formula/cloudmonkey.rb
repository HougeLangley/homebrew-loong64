class Cloudmonkey < Formula
  desc "Apache CloudStack CloudMonkey CLI"
  homepage "https://example.org/cloudmonkey"
  version "6.6.0"
  url "http://127.0.0.1:8080/brew/bottles/cloudmonkey--6.6.0.loongarch64.bottle.tar.gz"
  sha256 "5a28a196a20e14f6885ffd62f2eb5577aa3710ff1b2abd55bcb99110b2c1f910"

  def install
    bin.install "cloudmonkey"
  end

  test do
    system "#{bin}/cloudmonkey"
  end
end
