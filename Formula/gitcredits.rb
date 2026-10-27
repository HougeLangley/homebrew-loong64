class Gitcredits < Formula
  desc "Git log doesn't do them justice. Turn your contributors into movie stars."
  homepage "https://example.org/gitcredits"
  version "0.1.3"
  url "http://127.0.0.1:8080/brew/bottles/gitcredits--0.1.3.loongarch64.bottle.tar.gz"
  sha256 "4efca4ab37e6cc5ca214a89c70f6dc4491c4f0b5597125e5b627c65626dd636e"

  def install
    bin.install "gitcredits"
  end

  test do
    system "#{bin}/gitcredits"
  end
end
