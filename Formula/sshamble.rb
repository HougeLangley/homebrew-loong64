class Sshamble < Formula
  desc "SSHamble: Unexpected Exposures in SSH"
  homepage "https://example.org/sshamble"
  version "0.3.3"
  url "http://127.0.0.1:8080/brew/bottles/sshamble--0.3.3.loongarch64.bottle.tar.gz"
  sha256 "d6bdcb32ca39659417d665b0cc95d6bf51c6dc9f1520fe6f3688481b890dbc9f"

  def install
    bin.install "sshamble"
  end

  test do
    system "#{bin}/sshamble"
  end
end
