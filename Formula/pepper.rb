class Pepper < Formula
  desc "A tool for performing actions on GitHub repos or a single repo."
  homepage "https://example.org/pepper"
  version "0.6.4"
  url "http://127.0.0.1:8080/brew/bottles/pepper--0.6.4.loongarch64.bottle.tar.gz"
  sha256 "eecb2f54c7b15313d8736a4246fc217e1f28e66580936c456d5a946975fee8ac"

  def install
    bin.install "pepper"
  end

  test do
    system "#{bin}/pepper"
  end
end
