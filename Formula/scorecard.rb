class Scorecard < Formula
  desc "Security health metrics for Open Source"
  homepage "https://example.org/scorecard"
  version "5.6.0"
  url "http://127.0.0.1:8080/brew/bottles/scorecard--5.6.0.loongarch64.bottle.tar.gz"
  sha256 "c39e3122fc174b88f30ebdcaef1cfcba60e014c803e2c32622c428440131254a"

  def install
    bin.install "scorecard"
  end

  test do
    system "#{bin}/scorecard"
  end
end
