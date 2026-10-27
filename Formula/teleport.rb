class Teleport < Formula
  desc "The easiest, and most secure way to access and protect all of your infrastructure."
  homepage "https://example.org/teleport"
  version "18.10.0"
  url "http://127.0.0.1:8080/brew/bottles/teleport--18.10.0.loongarch64.bottle.tar.gz"
  sha256 "6af7bea7ac8fd3977ec67aec6aca813f0292a43cf1f6de5996ef19d3f25068c3"

  def install
    bin.install "teleport"
  end

  test do
    system "#{bin}/teleport"
  end
end
