class Bazelisk < Formula
  desc "User-friendly launcher for Bazel"
  homepage "https://example.org/bazelisk"
  version "1.30.0"
  url "http://127.0.0.1:8080/brew/bottles/bazelisk--1.30.0.loongarch64.bottle.tar.gz"
  sha256 "cee5b42c97e9d02a3541fc097d56ddc2798c99481c349ee6653ec9a276354015"

  def install
    bin.install "bazelisk"
  end

  test do
    system "#{bin}/bazelisk"
  end
end
