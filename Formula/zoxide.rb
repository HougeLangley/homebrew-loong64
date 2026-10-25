class Zoxide < Formula
  desc "Smarter cd command for your terminal"
  homepage "https://example.org/zoxide"
  version "0.10.0"
  url "http://127.0.0.1:8080/brew/bottles/zoxide--0.10.0.loongarch64.bottle.tar.gz"
  sha256 "78054be448cc1d842ca4a46136837007df7e7cd992fcd741776812b5abf60e55"

  def install
    bin.install "zoxide"
  end

  test do
    system "#{bin}/zoxide"
  end
end
