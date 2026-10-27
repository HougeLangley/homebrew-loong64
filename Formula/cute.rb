class Cute < Formula
  desc "Library for simply creating HTTP tests in Go with Allure reports."
  homepage "https://example.org/cute"
  version "0.1.24"
  url "http://127.0.0.1:8080/brew/bottles/cute--0.1.24.loongarch64.bottle.tar.gz"
  sha256 "8422bf9198653a82ebd1243e1f13822e11db416ebcefdf9daee4d0773f189389"

  def install
    bin.install "cute"
  end

  test do
    system "#{bin}/cute"
  end
end
