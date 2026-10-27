class Go-captcha < Formula
  desc "🖖 GoCaptcha: A high-performance, interactive behavior captcha library for Go. Supporting c"
  homepage "https://example.org/go-captcha"
  version "2.0.5"
  url "http://127.0.0.1:8080/brew/bottles/go-captcha--2.0.5.loongarch64.bottle.tar.gz"
  sha256 "8b88ee990dd0018cb9e46768b23e707450d34ea2906399ffd3fa844c485e53bc"

  def install
    bin.install "go-captcha"
  end

  test do
    system "#{bin}/go-captcha"
  end
end
