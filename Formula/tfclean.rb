class Tfclean < Formula
  desc "Remove applied moved block, import block, etc"
  homepage "https://example.org/tfclean"
  version "0.0.19"
  url "http://127.0.0.1:8080/brew/bottles/tfclean--0.0.19.loongarch64.bottle.tar.gz"
  sha256 "351b56524fcbe6a7016da894f108391f03a8e02b0c035e213c58b4166130c2e4"

  def install
    bin.install "tfclean"
  end

  test do
    system "#{bin}/tfclean"
  end
end
