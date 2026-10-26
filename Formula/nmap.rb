class Nmap < Formula
  desc "Network exploration and security scanner"
  homepage "https://example.org/nmap"
  version "7.992"
  url "http://127.0.0.1:8080/brew/bottles/nmap--7.992.loongarch64.bottle.tar.gz"
  sha256 "bcf3abd99cf3a950f86007d019df1949a0dc1232a375a7bffa50b4c86284ba4b"

  def install
    bin.install "nmap"
  end

  test do
    system "#{bin}/nmap"
  end
end
