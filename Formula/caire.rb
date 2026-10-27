class Caire < Formula
  desc "Content aware image resize tool"
  homepage "https://example.org/caire"
  version "1.5.0"
  url "http://127.0.0.1:8080/brew/bottles/caire--1.5.0.loongarch64.bottle.tar.gz"
  sha256 "2c11f90ef6efc21026c69311268edde9fb9a9e0ef48fddd0f0fca2bf6e71be28"

  def install
    bin.install "caire"
  end

  test do
    system "#{bin}/caire"
  end
end
