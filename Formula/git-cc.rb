class Git-cc < Formula
  desc "a git extension to help write conventional commits"
  homepage "https://example.org/git-cc"
  version "0.2.8-rc0"
  url "http://127.0.0.1:8080/brew/bottles/git-cc--0.2.8-rc0.loongarch64.bottle.tar.gz"
  sha256 "9cb3ad469baec997821440b062d6c5bad44c37a95655e047ab37ea1e428ab736"

  def install
    bin.install "git-cc"
  end

  test do
    system "#{bin}/git-cc"
  end
end
