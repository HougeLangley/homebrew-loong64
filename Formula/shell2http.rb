class Shell2http < Formula
  desc "Executing shell commands via HTTP server"
  homepage "https://example.org/shell2http"
  version "1.18.0"
  url "http://127.0.0.1:8080/brew/bottles/shell2http--1.18.0.loongarch64.bottle.tar.gz"
  sha256 "420f7066a5d0e21b1753fd504fe1c1230cd60af4953d12fbdfd1f22606f80da7"

  def install
    bin.install "shell2http"
  end

  test do
    system "#{bin}/shell2http"
  end
end
