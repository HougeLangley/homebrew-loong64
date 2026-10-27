class Osctrl-mcp < Formula
  desc "Fast and efficient osquery management"
  homepage "https://example.org/osctrl-mcp"
  version "0.6.1"
  url "http://127.0.0.1:8080/brew/bottles/osctrl-mcp--0.6.1.loongarch64.bottle.tar.gz"
  sha256 "3166676ba1cd7a01b877e63c22f802cebe1d8f4e144df32e36fd2dd33defe80a"

  def install
    bin.install "osctrl-mcp"
  end

  test do
    system "#{bin}/osctrl-mcp"
  end
end
