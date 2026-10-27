class Regal < Formula
  desc "Linter and language server for Rego"
  homepage "https://example.org/regal"
  version "0.43.0"
  url "http://127.0.0.1:8080/brew/bottles/regal--0.43.0.loongarch64.bottle.tar.gz"
  sha256 "2a70d705d14e5c0a920f02f881862d5613bf23b0398face58ca5c2b8cb3b2c11"

  def install
    bin.install "regal"
  end

  test do
    system "#{bin}/regal"
  end
end
