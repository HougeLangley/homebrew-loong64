class Devpod < Formula
  desc "Codespaces but open-source, client-only and unopinionated: Works with any IDE and lets you"
  homepage "https://example.org/devpod"
  version "0.6.15"
  url "http://127.0.0.1:8080/brew/bottles/devpod--0.6.15.loongarch64.bottle.tar.gz"
  sha256 "9f4d0162b7fd3db6e42fcadb9f468fcaee07354eee47c276a0723ea8aca65722"

  def install
    bin.install "devpod"
  end

  test do
    system "#{bin}/devpod"
  end
end
