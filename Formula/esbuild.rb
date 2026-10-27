class Esbuild < Formula
  desc "Extremely fast JavaScript bundler and minifier"
  homepage "https://example.org/esbuild"
  version "0.28.2"
  url "http://127.0.0.1:8080/brew/bottles/esbuild--0.28.2.loongarch64.bottle.tar.gz"
  sha256 "62326eadf8385988691d1000aa5de748ed0abbf207b782c81a55a1dc06c0781f"

  def install
    bin.install "esbuild"
  end

  test do
    system "#{bin}/esbuild"
  end
end
