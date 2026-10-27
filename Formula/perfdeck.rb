class Perfdeck < Formula
  desc "📊 A modern, lightweight, and customizable TUI performance monitor for your terminal. Built"
  homepage "https://example.org/perfdeck"
  version "0.4.2"
  url "http://127.0.0.1:8080/brew/bottles/perfdeck--0.4.2.loongarch64.bottle.tar.gz"
  sha256 "2cde50d8ba3b09740c7ec41fc73ae5a0912cc5ca492cd5fe8f2655d2988a994b"

  def install
    bin.install "perfdeck"
  end

  test do
    system "#{bin}/perfdeck"
  end
end
