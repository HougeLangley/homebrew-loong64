class Cli < Formula
  desc "GitHub’s official command line tool"
  homepage "https://example.org/cli"
  version "2.103.3"
  url "http://127.0.0.1:8080/brew/bottles/cli--2.103.3.loongarch64.bottle.tar.gz"
  sha256 "9da967e3670b08bf5530fb8eda022b58509edb22febc4c46bfd442457830e21e"

  def install
    bin.install "cli"
  end

  test do
    system "#{bin}/cli"
  end
end
