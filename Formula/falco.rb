class Falco < Formula
  desc "VCL parser and linter optimized for Fastly"
  homepage "https://example.org/falco"
  version "2.3.0"
  url "http://127.0.0.1:8080/brew/bottles/falco--2.3.0.loongarch64.bottle.tar.gz"
  sha256 "dfb382eca9705b9b849386ae9d2e290777aed0b6c38d46545edc60da091ef8bc"

  def install
    bin.install "falco"
  end

  test do
    system "#{bin}/falco"
  end
end
