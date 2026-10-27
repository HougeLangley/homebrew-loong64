class Haft < Formula
  desc "Engineering decisions engine that know when they're stale. Frame, compare, decide — with e"
  homepage "https://example.org/haft"
  version "9.1.0"
  url "http://127.0.0.1:8080/brew/bottles/haft--9.1.0.loongarch64.bottle.tar.gz"
  sha256 "a20c0a4c5f51d246d62719bccb3d78ec7f494e9cd78bebb6798d8ab9b3b31d5d"

  def install
    bin.install "haft"
  end

  test do
    system "#{bin}/haft"
  end
end
