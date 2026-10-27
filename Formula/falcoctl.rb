class Falcoctl < Formula
  desc "CLI tool for working with Falco and its ecosystem components"
  homepage "https://example.org/falcoctl"
  version "0.14.3"
  url "http://127.0.0.1:8080/brew/bottles/falcoctl--0.14.3.loongarch64.bottle.tar.gz"
  sha256 "27d0930a585db5aff98b8b48d7e15b3d1f58489770b0c217de10f9e25b9cd236"

  def install
    bin.install "falcoctl"
  end

  test do
    system "#{bin}/falcoctl"
  end
end
