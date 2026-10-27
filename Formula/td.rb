class Td < Formula
  desc "Your todo list in your terminal"
  homepage "https://example.org/td"
  version "1.4.2"
  url "http://127.0.0.1:8080/brew/bottles/td--1.4.2.loongarch64.bottle.tar.gz"
  sha256 "cdec6d6d32fc8e6c95b6bb692f683166592cd97c5d72f42fc35a59718fd39cdf"

  def install
    bin.install "td"
  end

  test do
    system "#{bin}/td"
  end
end
