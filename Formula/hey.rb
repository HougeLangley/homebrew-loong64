class Hey < Formula
  desc "HTTP load generator"
  homepage "https://example.org/hey"
  version "0.1.5"
  url "http://127.0.0.1:8080/brew/bottles/hey--0.1.5.loongarch64.bottle.tar.gz"
  sha256 "dbfd589646a95a748ae2e8bd781c1ec3373c064ecab0a5cf92013f60892d5b43"

  def install
    bin.install "hey"
  end

  test do
    system "#{bin}/hey"
  end
end
