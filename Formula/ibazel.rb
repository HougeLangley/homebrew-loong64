class Ibazel < Formula
  desc "Tools for building Bazel targets when source files change"
  homepage "https://example.org/ibazel"
  version "0.33.0"
  url "http://127.0.0.1:8080/brew/bottles/ibazel--0.33.0.loongarch64.bottle.tar.gz"
  sha256 "e0f2cb216bf97373f70a49592944948e5a35156ef34c57feb8df198f64dc439c"

  def install
    bin.install "ibazel"
  end

  test do
    system "#{bin}/ibazel"
  end
end
