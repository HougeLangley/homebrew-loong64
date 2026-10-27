class Ligolo-ng < Formula
  desc "An advanced, yet simple, tunneling/pivoting tool that uses a TUN interface."
  homepage "https://example.org/ligolo-ng"
  version "0.9.2"
  url "http://127.0.0.1:8080/brew/bottles/ligolo-ng--0.9.2.loongarch64.bottle.tar.gz"
  sha256 "a1a3039a20882e4b73b7b850375194696e0ef6a913742b337d8e5f035e06f8cd"

  def install
    bin.install "ligolo-ng"
  end

  test do
    system "#{bin}/ligolo-ng"
  end
end
