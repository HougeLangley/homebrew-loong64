class Newrelic-cli < Formula
  desc "Command-line interface for New Relic"
  homepage "https://example.org/newrelic-cli"
  version "0.115.2"
  url "http://127.0.0.1:8080/brew/bottles/newrelic-cli--0.115.2.loongarch64.bottle.tar.gz"
  sha256 "6a14e71e1cf9dace39a28def6a6214dec961f95a5ef56363d478a6c659d04f40"

  def install
    bin.install "newrelic-cli"
  end

  test do
    system "#{bin}/newrelic-cli"
  end
end
