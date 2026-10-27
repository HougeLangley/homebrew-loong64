class Fjira < Formula
  desc "Fuzzy-find cli jira interface"
  homepage "https://example.org/fjira"
  version "1.5.6"
  url "http://127.0.0.1:8080/brew/bottles/fjira--1.5.6.loongarch64.bottle.tar.gz"
  sha256 "eb1ea86ee119180c3e981fc3e5298c73e27b409e0b763adb917011890f09297e"

  def install
    bin.install "fjira"
  end

  test do
    system "#{bin}/fjira"
  end
end
