class Utask < Formula
  desc "µTask is an automation engine that models and executes business processes declared in yaml"
  homepage "https://example.org/utask"
  version "1.34.0"
  url "http://127.0.0.1:8080/brew/bottles/utask--1.34.0.loongarch64.bottle.tar.gz"
  sha256 "07ce91ab4b786a8367846d99bc7d17f33c96a4e7af8dd006b4299ae8a980a637"

  def install
    bin.install "utask"
  end

  test do
    system "#{bin}/utask"
  end
end
