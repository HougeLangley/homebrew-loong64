class Conftest < Formula
  desc "Test your configuration files using Open Policy Agent"
  homepage "https://example.org/conftest"
  version "0.71.1"
  url "http://127.0.0.1:8080/brew/bottles/conftest--0.71.1.loongarch64.bottle.tar.gz"
  sha256 "3bf1d0d8e4a2e15202b09b3afaec447bdd9ed04d05c237c5e57d9cbc4efdd17c"

  def install
    bin.install "conftest"
  end

  test do
    system "#{bin}/conftest"
  end
end
