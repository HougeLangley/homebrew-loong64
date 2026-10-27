class Shiori < Formula
  desc "Simple bookmark manager built with Go"
  homepage "https://example.org/shiori"
  version "1.8.0"
  url "http://127.0.0.1:8080/brew/bottles/shiori--1.8.0.loongarch64.bottle.tar.gz"
  sha256 "4ff6634ffd72713e1ddc638939f93cd541a61e558e86de055fdbfe597b351481"

  def install
    bin.install "shiori"
  end

  test do
    system "#{bin}/shiori"
  end
end
