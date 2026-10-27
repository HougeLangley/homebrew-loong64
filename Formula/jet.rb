class Jet < Formula
  desc "Type safe SQL builder with code generation and auto query result data mapping"
  homepage "https://example.org/jet"
  version "2.16.1"
  url "http://127.0.0.1:8080/brew/bottles/jet--2.16.1.loongarch64.bottle.tar.gz"
  sha256 "426110fdda3c1f8f4e34de787711d7b6e34562008b506635e262b5af517f2e95"

  def install
    bin.install "jet"
  end

  test do
    system "#{bin}/jet"
  end
end
