class Gatus < Formula
  desc "Automated developer-oriented status page with alerting and incident support"
  homepage "https://example.org/gatus"
  version "5.37.0"
  url "http://127.0.0.1:8080/brew/bottles/gatus--5.37.0.loongarch64.bottle.tar.gz"
  sha256 "9ceb04a44a313725585a594367e1289caf7ced73c92e3a2d31155a3eeb876f13"

  def install
    bin.install "gatus"
  end

  test do
    system "#{bin}/gatus"
  end
end
