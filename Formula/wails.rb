class Wails < Formula
  desc "Create beautiful applications using Go"
  homepage "https://example.org/wails"
  version "3.0.0"
  url "http://127.0.0.1:8080/brew/bottles/wails--3.0.0.loongarch64.bottle.tar.gz"
  sha256 "e5dcbef88bd86a8c3f8d0376749169342c108df581fa3b25d194f42f1993f7ed"

  def install
    bin.install "wails"
  end

  test do
    system "#{bin}/wails"
  end
end
