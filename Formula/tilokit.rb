class Tilokit < Formula
  desc "🚀 A simple CLI tool to scaffold multi-framework project structures (React, Vue, Next, Nuxt"
  homepage "https://example.org/tilokit"
  version "0.2.9-dev"
  url "http://127.0.0.1:8080/brew/bottles/tilokit--0.2.9-dev.loongarch64.bottle.tar.gz"
  sha256 "6b75436f3106bbcc059b5addecacc7309b528bfb99120a4181568affe1891426"

  def install
    bin.install "tilokit"
  end

  test do
    system "#{bin}/tilokit"
  end
end
