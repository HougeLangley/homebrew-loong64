class Cwai < Formula
  desc "AI-powered conventional commit message generator from staged git changes"
  homepage "https://example.org/cwai"
  version "0.1.1"
  url "http://127.0.0.1:8080/brew/bottles/cwai--0.1.1.loongarch64.bottle.tar.gz"
  sha256 "8b11da3805553dd8f79b443017397c94de0df9a755b839d25880623dd1f0ef77"

  def install
    bin.install "cwai"
  end

  test do
    system "#{bin}/cwai"
  end
end
