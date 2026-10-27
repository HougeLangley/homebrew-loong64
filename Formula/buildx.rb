class Buildx < Formula
  desc "Docker CLI plugin for extended build capabilities with BuildKit"
  homepage "https://example.org/buildx"
  version "0.38.1"
  url "http://127.0.0.1:8080/brew/bottles/buildx--0.38.1.loongarch64.bottle.tar.gz"
  sha256 "8cae555cf931756f33d8c5a580ce21d425d80725b184305456bc1b875445e0cf"

  def install
    bin.install "buildx"
  end

  test do
    system "#{bin}/buildx"
  end
end
