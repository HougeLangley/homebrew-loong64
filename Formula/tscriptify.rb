class Tscriptify < Formula
  desc "Golang struct to TypeScript class/interface converter"
  homepage "https://example.org/tscriptify"
  version "0.2.0"
  url "http://127.0.0.1:8080/brew/bottles/tscriptify--0.2.0.loongarch64.bottle.tar.gz"
  sha256 "685b0cd67e340f85302e3558be4754f82917052f1edcfbd80891f90baf8bb4bf"

  def install
    bin.install "tscriptify"
  end

  test do
    system "#{bin}/tscriptify"
  end
end
