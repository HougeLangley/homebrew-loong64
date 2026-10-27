class Memos < Formula
  desc "Memos is an open-source, self-hosted note-taking app that brings your everyday thoughts to"
  homepage "https://example.org/memos"
  version "0.31.0"
  url "http://127.0.0.1:8080/brew/bottles/memos--0.31.0.loongarch64.bottle.tar.gz"
  sha256 "934d15e48a052b361178dc88444cda01514f3970cadc67774667d9a0657fa379"

  def install
    bin.install "memos"
  end

  test do
    system "#{bin}/memos"
  end
end
