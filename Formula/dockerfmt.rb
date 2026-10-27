class Dockerfmt < Formula
  desc "Dockerfile format and parser. a modern dockfmt"
  homepage "https://example.org/dockerfmt"
  version "0.5.4"
  url "http://127.0.0.1:8080/brew/bottles/dockerfmt--0.5.4.loongarch64.bottle.tar.gz"
  sha256 "a5d7010a9083707a691d723796ba5e7a8df188d4cbe2cf0c1023dff3d43bf6d9"

  def install
    bin.install "dockerfmt"
  end

  test do
    system "#{bin}/dockerfmt"
  end
end
