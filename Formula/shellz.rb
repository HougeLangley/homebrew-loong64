class Shellz < Formula
  desc "Small utility to track and control custom shellz"
  homepage "https://example.org/shellz"
  version "1.6.0"
  url "http://127.0.0.1:8080/brew/bottles/shellz--1.6.0.loongarch64.bottle.tar.gz"
  sha256 "ef19dd2e217d3abe03100bab96badb62a09c10183b7b771f662f1d3adfe5ef21"

  def install
    bin.install "shellz"
  end

  test do
    system "#{bin}/shellz"
  end
end
