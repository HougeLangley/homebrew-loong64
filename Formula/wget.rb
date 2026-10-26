class Wget < Formula
  desc "Network downloader"
  homepage "https://example.org/wget"
  version "1.25.0"
  url "http://127.0.0.1:8080/brew/bottles/wget--1.25.0.loongarch64.bottle.tar.gz"
  sha256 "111af59ff183f2688e1958b0c0e4f3d68bf2e8e930553c374cd237fa7c8a98ec"

  def install
    bin.install "wget"
  end

  test do
    system "#{bin}/wget"
  end
end
