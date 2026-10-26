class Nushell < Formula
  desc "New type of shell"
  homepage "https://example.org/nushell"
  version "0.116.1"
  url "http://127.0.0.1:8080/brew/bottles/nushell--0.116.1.loongarch64.bottle.tar.gz"
  sha256 "763073971f01ff7051b01946c347727b3d5e733698cda91b6654757d5fd19d8c"

  def install
    bin.install "nushell"
  end

  test do
    system "#{bin}/nushell"
  end
end
