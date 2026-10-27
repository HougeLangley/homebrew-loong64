class Rad < Formula
  desc "Modern CLI scripts made easy"
  homepage "https://example.org/rad"
  version "0.12.1"
  url "http://127.0.0.1:8080/brew/bottles/rad--0.12.1.loongarch64.bottle.tar.gz"
  sha256 "29dcfb9724adccd3eb6d3b296786ecf8494578380ee99f94e1d356be21dc5ec2"

  def install
    bin.install "rad"
  end

  test do
    system "#{bin}/rad"
  end
end
