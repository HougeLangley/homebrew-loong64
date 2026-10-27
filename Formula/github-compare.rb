class Github-compare < Formula
  desc "A GitHub repositories statistics command-line tool for the terminal"
  homepage "https://example.org/github-compare"
  version "1.0.1"
  url "http://127.0.0.1:8080/brew/bottles/github-compare--1.0.1.loongarch64.bottle.tar.gz"
  sha256 "f8a38b4c08d9264d28fdab62aaa36b8460e0a2884f8e8883ea7bfc057b21a3a4"

  def install
    bin.install "github-compare"
  end

  test do
    system "#{bin}/github-compare"
  end
end
