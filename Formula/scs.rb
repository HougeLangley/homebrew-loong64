class Scs < Formula
  desc "HTTP Session Management for Go"
  homepage "https://example.org/scs"
  version "2.9.0"
  url "http://127.0.0.1:8080/brew/bottles/scs--2.9.0.loongarch64.bottle.tar.gz"
  sha256 "4eb472009e632f818201a8e005985d9d725dc52bb500e8493f060e20762c701e"

  def install
    bin.install "scs"
  end

  test do
    system "#{bin}/scs"
  end
end
