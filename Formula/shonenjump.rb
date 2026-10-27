class Shonenjump < Formula
  desc "A faster way to change directory and improve command line productivity."
  homepage "https://example.org/shonenjump"
  version "0.8.0"
  url "http://127.0.0.1:8080/brew/bottles/shonenjump--0.8.0.loongarch64.bottle.tar.gz"
  sha256 "139adba562a2849921bd9f6e4d368f2816689fcd4c535d123fb3168741a430a1"

  def install
    bin.install "shonenjump"
  end

  test do
    system "#{bin}/shonenjump"
  end
end
