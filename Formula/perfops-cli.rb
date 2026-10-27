class Perfops-cli < Formula
  desc "A simple command line tool to interact with hundreds of servers around the world. "
  homepage "https://example.org/perfops-cli"
  version "0.8.18"
  url "http://127.0.0.1:8080/brew/bottles/perfops-cli--0.8.18.loongarch64.bottle.tar.gz"
  sha256 "a7b58e85c0cb0262a198d5bdd4cd3a0d45cc75c3d477fe7e8fdd6d9bbc333eaa"

  def install
    bin.install "perfops-cli"
  end

  test do
    system "#{bin}/perfops-cli"
  end
end
