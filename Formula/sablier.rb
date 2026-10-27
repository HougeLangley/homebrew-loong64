class Sablier < Formula
  desc "Start your containers on demand, shut them down automatically when there's no activity. Do"
  homepage "https://example.org/sablier"
  version "1.18.0"
  url "http://127.0.0.1:8080/brew/bottles/sablier--1.18.0.loongarch64.bottle.tar.gz"
  sha256 "f2500a7197f5c8bb86a7a4d589210c84dc0716c0d7662cc0e18c5a23455b6674"

  def install
    bin.install "sablier"
  end

  test do
    system "#{bin}/sablier"
  end
end
