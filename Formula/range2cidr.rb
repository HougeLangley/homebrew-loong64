class Range2cidr < Formula
  desc "Converts IP ranges to CIDRs"
  homepage "https://example.org/range2cidr"
  version "ipinfo-3.3.3"
  url "http://127.0.0.1:8080/brew/bottles/range2cidr--ipinfo-3.3.3.loongarch64.bottle.tar.gz"
  sha256 "5f0dab102d078a232d0a1f1b9672e74283b769b3dccc0328f91569d1f4df36ca"

  def install
    bin.install "range2cidr"
  end

  test do
    system "#{bin}/range2cidr"
  end
end
