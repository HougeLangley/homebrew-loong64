class Aide < Formula
  desc "File and directory integrity checker"
  homepage "https://example.org/aide"
  version "0.19.5"
  url "http://127.0.0.1:8080/brew/bottles/aide--0.19.5.loongarch64.bottle.tar.gz"
  sha256 "60289ccba32e433058054c639e67b239bd2a1d44ff1a6734c2fbad0056e2ea1f"

  def install
    bin.install "aide"
  end

  test do
    system "#{bin}/aide"
  end
end
