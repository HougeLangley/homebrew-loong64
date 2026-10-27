class Counterfeiter < Formula
  desc "Tool for generating self-contained, type-safe test doubles in go"
  homepage "https://example.org/counterfeiter"
  version "6.14.0"
  url "http://127.0.0.1:8080/brew/bottles/counterfeiter--6.14.0.loongarch64.bottle.tar.gz"
  sha256 "5ab6aab7abc7342c84d7b4bdcc4544c6198f4cc8b951aef7c8cf3a3f85cd75f7"

  def install
    bin.install "counterfeiter"
  end

  test do
    system "#{bin}/counterfeiter"
  end
end
