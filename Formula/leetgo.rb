class Leetgo < Formula
  desc "CLI tool for LeetCode"
  homepage "https://example.org/leetgo"
  version "1.5.2"
  url "http://127.0.0.1:8080/brew/bottles/leetgo--1.5.2.loongarch64.bottle.tar.gz"
  sha256 "6360ff8449af2d7ed3da3fd7dcd3a44ce04705006a16762ec33e4cd7418b994e"

  def install
    bin.install "leetgo"
  end

  test do
    system "#{bin}/leetgo"
  end
end
