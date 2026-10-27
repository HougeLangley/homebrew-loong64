class Inframap < Formula
  desc "Read your tfstate or HCL to generate a graph"
  homepage "https://example.org/inframap"
  version "0.8.1"
  url "http://127.0.0.1:8080/brew/bottles/inframap--0.8.1.loongarch64.bottle.tar.gz"
  sha256 "a456d45a455ed618ad8bc6d6be7a59545aab9769260bd78ce0191255a01271db"

  def install
    bin.install "inframap"
  end

  test do
    system "#{bin}/inframap"
  end
end
