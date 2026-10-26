class Gitui < Formula
  desc "Terminal UI for git"
  homepage "https://example.org/gitui"
  version "0.28.1"
  url "http://127.0.0.1:8080/brew/bottles/gitui--0.28.1.loongarch64.bottle.tar.gz"
  sha256 "94be069d60f8d1006cd82d88967ef953a3ad382a4263afaa4e167722feec043c"

  def install
    bin.install "gitui"
  end

  test do
    system "#{bin}/gitui"
  end
end
