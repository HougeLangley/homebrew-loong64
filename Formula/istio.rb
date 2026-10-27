class Istio < Formula
  desc "Connect, secure, control, and observe services."
  homepage "https://example.org/istio"
  version "1.31.3"
  url "http://127.0.0.1:8080/brew/bottles/istio--1.31.3.loongarch64.bottle.tar.gz"
  sha256 "9086316370f0e51a06b0b310875ef211bbd68898fc725f1ad9bef03d2565e60c"

  def install
    bin.install "istio"
  end

  test do
    system "#{bin}/istio"
  end
end
