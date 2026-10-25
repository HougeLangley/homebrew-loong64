class Pv < Formula
  desc "Monitor the progress of data through a pipe"
  homepage "https://example.org/pv"
  version "1.12.0"
  url "http://127.0.0.1:8080/brew/bottles/pv--1.12.0.loongarch64.bottle.tar.gz"
  sha256 "8ab20b94f693c21e10ffdfa04dd0cb82e6167bebbf2794bb257dfce40ade64d2"

  def install
    bin.install "pv"
  end

  test do
    system "#{bin}/pv"
  end
end
