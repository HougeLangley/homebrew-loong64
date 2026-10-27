class Nerdlog < Formula
  desc "TUI log viewer with timeline histogram and no central server"
  homepage "https://example.org/nerdlog"
  version "1.13.0"
  url "http://127.0.0.1:8080/brew/bottles/nerdlog--1.13.0.loongarch64.bottle.tar.gz"
  sha256 "09fc35570129d02f74106ad7e74b5780612cb1beef510d80fc6f9f76ff686372"

  def install
    bin.install "nerdlog"
  end

  test do
    system "#{bin}/nerdlog"
  end
end
