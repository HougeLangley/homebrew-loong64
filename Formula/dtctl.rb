class Dtctl < Formula
  desc "CLI for managing Dynatrace platform resources - built for humans and AI agents"
  homepage "https://example.org/dtctl"
  version "0.45.0"
  url "http://127.0.0.1:8080/brew/bottles/dtctl--0.45.0.loongarch64.bottle.tar.gz"
  sha256 "85024b0df9e249a50b3b9984922109699dc4c3815daa40da37646faf00624a8e"

  def install
    bin.install "dtctl"
  end

  test do
    system "#{bin}/dtctl"
  end
end
