class Scilla < Formula
  desc "Information Gathering tool - DNS / Subdomains / Ports / Directories enumeration"
  homepage "https://example.org/scilla"
  version "1.3.4"
  url "http://127.0.0.1:8080/brew/bottles/scilla--1.3.4.loongarch64.bottle.tar.gz"
  sha256 "b7ac7b0347d7bff15d56d9574445e71342ac15adc5cf3e0a581ba8aa3bef0781"

  def install
    bin.install "scilla"
  end

  test do
    system "#{bin}/scilla"
  end
end
