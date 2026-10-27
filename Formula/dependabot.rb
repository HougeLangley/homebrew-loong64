class Dependabot < Formula
  desc "Tool for testing and debugging Dependabot update jobs"
  homepage "https://example.org/dependabot"
  version "1.96.0"
  url "http://127.0.0.1:8080/brew/bottles/dependabot--1.96.0.loongarch64.bottle.tar.gz"
  sha256 "07276d391e42a712532682e875a20e5e112b9a97f432a51198ec3a103729a1e9"

  def install
    bin.install "dependabot"
  end

  test do
    system "#{bin}/dependabot"
  end
end
