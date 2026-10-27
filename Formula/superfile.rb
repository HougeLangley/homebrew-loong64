class Superfile < Formula
  desc "Pretty fancy and modern terminal file manager"
  homepage "https://example.org/superfile"
  version "1.6.0"
  url "http://127.0.0.1:8080/brew/bottles/superfile--1.6.0.loongarch64.bottle.tar.gz"
  sha256 "52c250e25e05803862712f2563d01e48485ed022449bc8e82343c7aa0b167d39"

  def install
    bin.install "superfile"
  end

  test do
    system "#{bin}/superfile"
  end
end
