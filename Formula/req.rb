class Req < Formula
  desc "Simple Go HTTP client with Black Magic"
  homepage "https://example.org/req"
  version "3.61.0"
  url "http://127.0.0.1:8080/brew/bottles/req--3.61.0.loongarch64.bottle.tar.gz"
  sha256 "a51148e52750861e8ef3c6d9a993531299891a31fc04403f764e7de3cff82b0b"

  def install
    bin.install "req"
  end

  test do
    system "#{bin}/req"
  end
end
