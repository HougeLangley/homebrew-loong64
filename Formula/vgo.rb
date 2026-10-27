class Vgo < Formula
  desc "Project scaffolder for Go, written in Go"
  homepage "https://example.org/vgo"
  version "0.3.0"
  url "http://127.0.0.1:8080/brew/bottles/vgo--0.3.0.loongarch64.bottle.tar.gz"
  sha256 "df66acee8cc4ed5953ff45443c8e83020a4617d7d69f38f3a50e9a1b2bf6eedf"

  def install
    bin.install "vgo"
  end

  test do
    system "#{bin}/vgo"
  end
end
