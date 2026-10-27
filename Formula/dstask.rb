class Dstask < Formula
  desc "Git powered terminal-based todo/note manager --  markdown note page per task. Single binar"
  homepage "https://example.org/dstask"
  version "1.0.1"
  url "http://127.0.0.1:8080/brew/bottles/dstask--1.0.1.loongarch64.bottle.tar.gz"
  sha256 "9cdc93833299a165c4fdacdb738c879635eb9ddd58a55ce95d376a2acebd6255"

  def install
    bin.install "dstask"
  end

  test do
    system "#{bin}/dstask"
  end
end
