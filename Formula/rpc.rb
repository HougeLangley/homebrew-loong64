class Rpc < Formula
  desc "Simple RPC style APIs with generated clients & servers."
  homepage "https://example.org/rpc"
  version "0.3.2"
  url "http://127.0.0.1:8080/brew/bottles/rpc--0.3.2.loongarch64.bottle.tar.gz"
  sha256 "cd1fc8ade2d620202cbcba8c30cf7859988c29d1ec6d4027da5987cd204a9239"

  def install
    bin.install "rpc"
  end

  test do
    system "#{bin}/rpc"
  end
end
