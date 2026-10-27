class Pterm < Formula
  desc "✨ PTerm is a modern Go module to easily beautify console output. Featuring charts, progres"
  homepage "https://example.org/pterm"
  version "0.12.84"
  url "http://127.0.0.1:8080/brew/bottles/pterm--0.12.84.loongarch64.bottle.tar.gz"
  sha256 "16b053cc50c58928bfab06b1db34381ff70c6686be9cc5e0fcd316cd55ae4da7"

  def install
    bin.install "pterm"
  end

  test do
    system "#{bin}/pterm"
  end
end
