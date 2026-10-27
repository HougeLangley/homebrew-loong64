class Jvgrep < Formula
  desc "Grep for Japanese users of Vim"
  homepage "https://example.org/jvgrep"
  version "5.8.16"
  url "http://127.0.0.1:8080/brew/bottles/jvgrep--5.8.16.loongarch64.bottle.tar.gz"
  sha256 "38b9f6b0de0481d3680b13434013375fb8ee8baf3d170108f3f4350a30e5f362"

  def install
    bin.install "jvgrep"
  end

  test do
    system "#{bin}/jvgrep"
  end
end
