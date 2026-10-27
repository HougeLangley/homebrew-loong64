class Ishell < Formula
  desc "Library for creating interactive cli applications."
  homepage "https://example.org/ishell"
  version "2.0.2"
  url "http://127.0.0.1:8080/brew/bottles/ishell--2.0.2.loongarch64.bottle.tar.gz"
  sha256 "2dd6d21964f0e5cb42efcba4c989c2a7013633d008bbd84dff7191781a506aab"

  def install
    bin.install "ishell"
  end

  test do
    system "#{bin}/ishell"
  end
end
