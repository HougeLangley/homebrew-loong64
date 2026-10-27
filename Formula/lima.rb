class Lima < Formula
  desc "Linux virtual machines"
  homepage "https://example.org/lima"
  version "2.2.1"
  url "http://127.0.0.1:8080/brew/bottles/lima--2.2.1.loongarch64.bottle.tar.gz"
  sha256 "0ca70e74438150eaaa794bff5e3b095fb6ef8066cb957d4abb95df40c6a4a0a9"

  def install
    bin.install "lima"
  end

  test do
    system "#{bin}/lima"
  end
end
