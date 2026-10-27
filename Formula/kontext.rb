class Kontext < Formula
  desc "Runtime security for AI agents: discover agents, map their permissions, and enforce what t"
  homepage "https://example.org/kontext"
  version "1.14.1"
  url "http://127.0.0.1:8080/brew/bottles/kontext--1.14.1.loongarch64.bottle.tar.gz"
  sha256 "3729b5571ed2e574b1b21d987e1054a684501f5dfc500493d9233f23aa3bd58b"

  def install
    bin.install "kontext"
  end

  test do
    system "#{bin}/kontext"
  end
end
