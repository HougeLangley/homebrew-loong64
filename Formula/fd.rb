class Fd < Formula
  desc "Simple, fast and user-friendly alternative to find"
  homepage "https://example.org/fd"
  version "10.5.0"
  url "http://127.0.0.1:8080/brew/bottles/fd--10.5.0.loongarch64.bottle.tar.gz"
  sha256 "c8ce26b0e75586ecc386d0e55c408a8b8759f72c6d7f97ce4859236023435086"

  def install
    bin.install "fd"
  end

  test do
    system "#{bin}/fd"
  end
end
