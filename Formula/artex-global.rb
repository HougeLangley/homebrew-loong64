class Artex-global < Formula
  desc "ARTEX 한국어판 · AI 자율 침투 테스트 프레임워크(upstream: Autumn-27/ARTEX, AGPL-3.0)"
  homepage "https://example.org/artex-global"
  version "0.3.15-global.1"
  url "http://127.0.0.1:8080/brew/bottles/artex-global--0.3.15-global.1.loongarch64.bottle.tar.gz"
  sha256 "8b869fe1937297cbe77fa431a36ab65ca98ad0e4f55b999f098a8a237466a84e"

  def install
    bin.install "artex-global"
  end

  test do
    system "#{bin}/artex-global"
  end
end
