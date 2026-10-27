class Urlfinder < Formula
  desc "Extracting URLs and subdomains from JS files on a website"
  homepage "https://example.org/urlfinder"
  version "2026.6.16"
  url "http://127.0.0.1:8080/brew/bottles/urlfinder--2026.6.16.loongarch64.bottle.tar.gz"
  sha256 "8c65ae5603f69b0ad850932f42197adb08f28c81aa637ddc38d6acd83f4e2d39"

  def install
    bin.install "urlfinder"
  end

  test do
    system "#{bin}/urlfinder"
  end
end
