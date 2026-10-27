class Copacetic < Formula
  desc "🧵 CLI tool for directly patching container images!"
  homepage "https://example.org/copacetic"
  version "0.15.0"
  url "http://127.0.0.1:8080/brew/bottles/copacetic--0.15.0.loongarch64.bottle.tar.gz"
  sha256 "bf82c82b7ededc3412651ee4867003d3f70df81ee52625df728536e763e527b1"

  def install
    bin.install "copacetic"
  end

  test do
    system "#{bin}/copacetic"
  end
end
