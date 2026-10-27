class Roxctl < Formula
  desc "CLI for Stackrox"
  homepage "https://example.org/roxctl"
  version "4.11.6"
  url "http://127.0.0.1:8080/brew/bottles/roxctl--4.11.6.loongarch64.bottle.tar.gz"
  sha256 "0b69f93522536f431c996e2e2735f4bcd30b2736b1dbed4dddbaf9ced760af8d"

  def install
    bin.install "roxctl"
  end

  test do
    system "#{bin}/roxctl"
  end
end
