class Flow < Formula
  desc "see ur network breathe"
  homepage "https://example.org/flow"
  version "0.3.5"
  url "http://127.0.0.1:8080/brew/bottles/flow--0.3.5.loongarch64.bottle.tar.gz"
  sha256 "f5ece4de7336f914a7631838a6227e4046802fd9d34059a22ca22f032113b61b"

  def install
    bin.install "flow"
  end

  test do
    system "#{bin}/flow"
  end
end
