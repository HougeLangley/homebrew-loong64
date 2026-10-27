class Pocketbase < Formula
  desc "Open source backend for your next project in 1 file"
  homepage "https://example.org/pocketbase"
  version "0.40.6"
  url "http://127.0.0.1:8080/brew/bottles/pocketbase--0.40.6.loongarch64.bottle.tar.gz"
  sha256 "85c5b54f2b08ff5707551228a53db1d11999654f12b227c36b03c2e3b33dbe3a"

  def install
    bin.install "pocketbase"
  end

  test do
    system "#{bin}/pocketbase"
  end
end
