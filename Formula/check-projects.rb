class Check-projects < Formula
  desc "✨​ A fast, cross-platform CLI tool to check the git status of multiple projects organized "
  homepage "https://example.org/check-projects"
  version "1.2.19"
  url "http://127.0.0.1:8080/brew/bottles/check-projects--1.2.19.loongarch64.bottle.tar.gz"
  sha256 "7d7ac25d18108e3ef9cb6fe63e219bfdcd4a394cd58bd0c4306ddf720d7f49f4"

  def install
    bin.install "check-projects"
  end

  test do
    system "#{bin}/check-projects"
  end
end
