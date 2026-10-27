class Lfk < Formula
  desc "Terminal user interface for navigating and managing Kubernetes clusters"
  homepage "https://example.org/lfk"
  version "0.19.12"
  url "http://127.0.0.1:8080/brew/bottles/lfk--0.19.12.loongarch64.bottle.tar.gz"
  sha256 "3899adc2354c76404b680afdbad7b818bf42df880744b269ae455523b49b0437"

  def install
    bin.install "lfk"
  end

  test do
    system "#{bin}/lfk"
  end
end
