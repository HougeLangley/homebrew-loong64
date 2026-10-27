class Mob < Formula
  desc "Tool for smooth git handover."
  homepage "https://example.org/mob"
  version "5.4.2"
  url "http://127.0.0.1:8080/brew/bottles/mob--5.4.2.loongarch64.bottle.tar.gz"
  sha256 "b399ff23deb016bf23f2ca8ad6a1259ab3cc8af11f0897629bc1f161fe590c07"

  def install
    bin.install "mob"
  end

  test do
    system "#{bin}/mob"
  end
end
