class Ergo < Formula
  desc "The management of multiple apps running over different ports made easy"
  homepage "https://example.org/ergo"
  version "0.4.1"
  url "http://127.0.0.1:8080/brew/bottles/ergo--0.4.1.loongarch64.bottle.tar.gz"
  sha256 "b05e099db8518f416e85c99bf7c7bbebdfc1ad89c4f4444006f5a4eab78b92de"

  def install
    bin.install "ergo"
  end

  test do
    system "#{bin}/ergo"
  end
end
