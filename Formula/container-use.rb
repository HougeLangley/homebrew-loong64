class Container-use < Formula
  desc "Dev envs for coding agents. Run multiple agents safely with your stack"
  homepage "https://example.org/container-use"
  version "0.4.2"
  url "http://127.0.0.1:8080/brew/bottles/container-use--0.4.2.loongarch64.bottle.tar.gz"
  sha256 "cbbabd420ccb1ef6da38ffeb43205437c2bf90ca52b5d8c72f38d16ca260bd3d"

  def install
    bin.install "container-use"
  end

  test do
    system "#{bin}/container-use"
  end
end
