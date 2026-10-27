class Checkmake < Formula
  desc "Linter/analyzer for Makefiles"
  homepage "https://example.org/checkmake"
  version "0.3.2"
  url "http://127.0.0.1:8080/brew/bottles/checkmake--0.3.2.loongarch64.bottle.tar.gz"
  sha256 "c28ebdcc4dcd6f7531d84c9bb3161e28add00056539b53c467c4cee7d80c4d26"

  def install
    bin.install "checkmake"
  end

  test do
    system "#{bin}/checkmake"
  end
end
