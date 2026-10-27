class Brutespray < Formula
  desc "Fast, multi-protocol credential brute-forcer. Parses Nmap, Nessus, and Nexpose output to a"
  homepage "https://example.org/brutespray"
  version "2.7.2"
  url "http://127.0.0.1:8080/brew/bottles/brutespray--2.7.2.loongarch64.bottle.tar.gz"
  sha256 "97da06a3c1e791f4b18b69fd70f1463d425c2c16e98facbab9f04e921425693c"

  def install
    bin.install "brutespray"
  end

  test do
    system "#{bin}/brutespray"
  end
end
