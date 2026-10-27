class Pastelocal < Formula
  desc "Secure clipboard sharing over SSH for remote work and agentic coding tools."
  homepage "https://example.org/pastelocal"
  version "0.1.0"
  url "http://127.0.0.1:8080/brew/bottles/pastelocal--0.1.0.loongarch64.bottle.tar.gz"
  sha256 "d19ccd3405151b3b8e892a3c3aa4ddecb68bd7c9db8aed3c3e3e1ba962064fb3"

  def install
    bin.install "pastelocal"
  end

  test do
    system "#{bin}/pastelocal"
  end
end
