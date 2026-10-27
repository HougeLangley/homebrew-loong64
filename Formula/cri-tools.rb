class Cri-tools < Formula
  desc "CLI and validation tools for Kubelet Container Runtime Interface (CRI)"
  homepage "https://example.org/cri-tools"
  version "1.37.0"
  url "http://127.0.0.1:8080/brew/bottles/cri-tools--1.37.0.loongarch64.bottle.tar.gz"
  sha256 "2f7cc7647f84a744b00bbf0cc0bbfcf7e7609cca47f386530985c2dbda11dfcf"

  def install
    bin.install "cri-tools"
  end

  test do
    system "#{bin}/cri-tools"
  end
end
