class Lazyskills < Formula
  desc "mission control for agent skills"
  homepage "https://example.org/lazyskills"
  version "1.2.0"
  url "http://127.0.0.1:8080/brew/bottles/lazyskills--1.2.0.loongarch64.bottle.tar.gz"
  sha256 "ac073e921b529bacd7f33b5ba1095738ecfac7a8ad71b554a7aaf808718298d2"

  def install
    bin.install "lazyskills"
  end

  test do
    system "#{bin}/lazyskills"
  end
end
