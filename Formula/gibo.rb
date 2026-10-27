class Gibo < Formula
  desc "Easy access to gitignore boilerplates"
  homepage "https://example.org/gibo"
  version "3.0.23"
  url "http://127.0.0.1:8080/brew/bottles/gibo--3.0.23.loongarch64.bottle.tar.gz"
  sha256 "6edf2c534861767be86acdd36cd4b6f89a29d3f166c731ab7761db3551efec51"

  def install
    bin.install "gibo"
  end

  test do
    system "#{bin}/gibo"
  end
end
