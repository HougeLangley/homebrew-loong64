class Glamour < Formula
  desc "Stylesheet-based markdown rendering for your CLI apps 💇🏻‍♀️"
  homepage "https://example.org/glamour"
  version "2.0.1"
  url "http://127.0.0.1:8080/brew/bottles/glamour--2.0.1.loongarch64.bottle.tar.gz"
  sha256 "50912450aa791a4a1e9cb0600ebe4b3df60d454dfe21b13e09404f5013e8afba"

  def install
    bin.install "glamour"
  end

  test do
    system "#{bin}/glamour"
  end
end
