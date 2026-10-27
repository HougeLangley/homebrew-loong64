class Jira-cli < Formula
  desc "🔥 Feature-rich interactive Jira command line."
  homepage "https://example.org/jira-cli"
  version "1.7.0"
  url "http://127.0.0.1:8080/brew/bottles/jira-cli--1.7.0.loongarch64.bottle.tar.gz"
  sha256 "c985d28e0f8663351f650470522566da6fdae38b2b2bf9cdcab1a05c06214cf9"

  def install
    bin.install "jira-cli"
  end

  test do
    system "#{bin}/jira-cli"
  end
end
