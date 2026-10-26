class Procs < Formula
  desc "Modern replacement for ps written in Rust"
  homepage "https://example.org/procs"
  version "0.14.12"
  url "http://127.0.0.1:8080/brew/bottles/procs--0.14.12.loongarch64.bottle.tar.gz"
  sha256 "382f9c956cf60e81b38bb36a574c5b39dae9fb3e997381810a5e29c2261371dc"

  def install
    bin.install "procs"
  end

  test do
    system "#{bin}/procs"
  end
end
