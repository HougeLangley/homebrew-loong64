class Karmabot < Formula
  desc "upvotes and downvotes for slack"
  homepage "https://example.org/karmabot"
  version "1.6.0"
  url "http://127.0.0.1:8080/brew/bottles/karmabot--1.6.0.loongarch64.bottle.tar.gz"
  sha256 "9f790d287296b8a7d34e88f11b7cf8e6222bc78fd3867591207d7b3058e4dbbd"

  def install
    bin.install "karmabot"
  end

  test do
    system "#{bin}/karmabot"
  end
end
