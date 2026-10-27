class Bearer < Formula
  desc "Code security scanning tool (SAST) to discover, filter and prioritize security and privacy"
  homepage "https://example.org/bearer"
  version "2.1.2"
  url "http://127.0.0.1:8080/brew/bottles/bearer--2.1.2.loongarch64.bottle.tar.gz"
  sha256 "b9adc7afd89181d5296508397381aad450a206159fec911879938a5ea19dfddb"

  def install
    bin.install "bearer"
  end

  test do
    system "#{bin}/bearer"
  end
end
