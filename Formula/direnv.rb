class Direnv < Formula
  desc "Unclutter your .profile"
  homepage "https://example.org/direnv"
  version "2.38.2"
  url "http://127.0.0.1:8080/brew/bottles/direnv--2.38.2.loongarch64.bottle.tar.gz"
  sha256 "21e86279a5a0be68277cd4ab46ad1d6c196cd1c1ff906f0f44f6571a9fd7271c"

  def install
    bin.install "direnv"
  end

  test do
    system "#{bin}/direnv"
  end
end
