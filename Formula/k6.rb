class K6 < Formula
  desc "Modern load testing tool, using Go and JavaScript"
  homepage "https://example.org/k6"
  version "2.3.0"
  url "http://127.0.0.1:8080/brew/bottles/k6--2.3.0.loongarch64.bottle.tar.gz"
  sha256 "2c268573058fdb353c520887fb19cd2b0863d430d466edb23e57f5e3ada01d28"

  def install
    bin.install "k6"
  end

  test do
    system "#{bin}/k6"
  end
end
