class Gptscript < Formula
  desc "Develop LLM Apps in Natural Language"
  homepage "https://example.org/gptscript"
  version "0.9.9"
  url "http://127.0.0.1:8080/brew/bottles/gptscript--0.9.9.loongarch64.bottle.tar.gz"
  sha256 "1228229dcc6d551c72edc1e308e6182294a333871aff196f4e8884f85f1093af"

  def install
    bin.install "gptscript"
  end

  test do
    system "#{bin}/gptscript"
  end
end
