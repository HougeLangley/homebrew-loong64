class Immortal < Formula
  desc "⭕  A *nix cross-platform (OS agnostic) supervisor"
  homepage "https://example.org/immortal"
  version "0.24.7"
  url "http://127.0.0.1:8080/brew/bottles/immortal--0.24.7.loongarch64.bottle.tar.gz"
  sha256 "51ccf8d13348af1359e27a09d52eede96f663866e94f6b13cc00868548d0085d"

  def install
    bin.install "immortal"
  end

  test do
    system "#{bin}/immortal"
  end
end
