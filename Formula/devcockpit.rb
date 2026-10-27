class Devcockpit < Formula
  desc "TUI system monitor for Apple Silicon"
  homepage "https://example.org/devcockpit"
  version "3.0.0"
  url "http://127.0.0.1:8080/brew/bottles/devcockpit--3.0.0.loongarch64.bottle.tar.gz"
  sha256 "a2f1c904cad466a95c89803ee560a5328b90636a653b4c050b3a43cbf413a5b1"

  def install
    bin.install "devcockpit"
  end

  test do
    system "#{bin}/devcockpit"
  end
end
