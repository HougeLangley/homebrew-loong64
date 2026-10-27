class Step < Formula
  desc "Crypto and x509 Swiss-Army-Knife"
  homepage "https://example.org/step"
  version "0.31.0"
  url "http://127.0.0.1:8080/brew/bottles/step--0.31.0.loongarch64.bottle.tar.gz"
  sha256 "a0f075f3d25a140705b046a25cd81a13b9163511f8c25e5ddb051e80eb43354d"

  def install
    bin.install "step"
  end

  test do
    system "#{bin}/step"
  end
end
