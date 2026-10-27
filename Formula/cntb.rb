class Cntb < Formula
  desc "Contabo Command Line Interface"
  homepage "https://example.org/cntb"
  version "1.7"
  url "http://127.0.0.1:8080/brew/bottles/cntb--1.7.loongarch64.bottle.tar.gz"
  sha256 "30e4cb843c26e2ac69725bb91d01de4898730c40a7a188cab5f748b1b5c844d2"

  def install
    bin.install "cntb"
  end

  test do
    system "#{bin}/cntb"
  end
end
