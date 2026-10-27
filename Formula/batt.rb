class Batt < Formula
  desc "Control and limit battery charging on Apple Silicon MacBooks"
  homepage "https://example.org/batt"
  version "0.8.0"
  url "http://127.0.0.1:8080/brew/bottles/batt--0.8.0.loongarch64.bottle.tar.gz"
  sha256 "ce4ff26a51044e5c4387b514cbf1f7233f4f8f42b8b9a076b765a425a982615d"

  def install
    bin.install "batt"
  end

  test do
    system "#{bin}/batt"
  end
end
