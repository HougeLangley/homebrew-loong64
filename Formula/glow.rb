class Glow < Formula
  desc "Render markdown on the CLI"
  homepage "https://example.org/glow"
  version "3.0.0"
  url "http://127.0.0.1:8080/brew/bottles/glow--3.0.0.loongarch64.bottle.tar.gz"
  sha256 "dd3144e18f60b6c3d2bffceef5bfc26b3c70c9f99c9796c3a1936504d917a5eb"

  def install
    bin.install "glow"
  end

  test do
    system "#{bin}/glow"
  end
end
