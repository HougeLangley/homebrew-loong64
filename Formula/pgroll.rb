class Pgroll < Formula
  desc "Postgres zero-downtime migrations made easy"
  homepage "https://example.org/pgroll"
  version "0.16.3"
  url "http://127.0.0.1:8080/brew/bottles/pgroll--0.16.3.loongarch64.bottle.tar.gz"
  sha256 "cc8fec480a612c5f79db3925f0b11e0a596117e34a934c7c1776f660b9c35378"

  def install
    bin.install "pgroll"
  end

  test do
    system "#{bin}/pgroll"
  end
end
