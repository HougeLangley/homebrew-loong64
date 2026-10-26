class Rsync < Formula
  desc "Fast incremental file transfer"
  homepage "https://example.org/rsync"
  version "3.5.1"
  url "http://127.0.0.1:8080/brew/bottles/rsync--3.5.1.loongarch64.bottle.tar.gz"
  sha256 "4335d3ed77c97f92099fb12659a5b2fda3767febb10a99b89a14dc6563f0f7b6"

  def install
    bin.install "rsync"
  end

  test do
    system "#{bin}/rsync"
  end
end
