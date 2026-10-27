class Mightypie-revamped < Formula
  desc "Window Switcher (and more) as a Pie / Radial Menu"
  homepage "https://example.org/mightypie-revamped"
  version "1.2.1"
  url "http://127.0.0.1:8080/brew/bottles/mightypie-revamped--1.2.1.loongarch64.bottle.tar.gz"
  sha256 "a25da4e0fc87e26fd2529d49f2bf351c2f831fcced950374277e19a806b96dd9"

  def install
    bin.install "mightypie-revamped"
  end

  test do
    system "#{bin}/mightypie-revamped"
  end
end
