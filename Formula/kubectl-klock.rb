class Kubectl-klock < Formula
  desc "Kubectl plugin to render watch output in a more readable fashion"
  homepage "https://example.org/kubectl-klock"
  version "0.9.3"
  url "http://127.0.0.1:8080/brew/bottles/kubectl-klock--0.9.3.loongarch64.bottle.tar.gz"
  sha256 "9aad5aa2c85f29553dfac7781e047d14d63ef31ba1fb9a6ceb7822f950b1a00d"

  def install
    bin.install "kubectl-klock"
  end

  test do
    system "#{bin}/kubectl-klock"
  end
end
