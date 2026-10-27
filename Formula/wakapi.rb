class Wakapi < Formula
  desc "📊 A minimalist, self-hosted WakaTime-compatible backend for coding statistics"
  homepage "https://example.org/wakapi"
  version "2.18.2"
  url "http://127.0.0.1:8080/brew/bottles/wakapi--2.18.2.loongarch64.bottle.tar.gz"
  sha256 "12fe27d86f0918d94452312cdca6d2d03af925b5263810792db68e25cdc4bd87"

  def install
    bin.install "wakapi"
  end

  test do
    system "#{bin}/wakapi"
  end
end
