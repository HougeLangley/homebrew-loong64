class Permify < Formula
  desc "An open-source authorization as a service inspired by Google Zanzibar, designed to build a"
  homepage "https://example.org/permify"
  version "1.7.5"
  url "http://127.0.0.1:8080/brew/bottles/permify--1.7.5.loongarch64.bottle.tar.gz"
  sha256 "8efdfb01e3e3e1b4cae50cd31fb9e0a23a94fb7e1a34055aa43c9a8364ca8c3c"

  def install
    bin.install "permify"
  end

  test do
    system "#{bin}/permify"
  end
end
