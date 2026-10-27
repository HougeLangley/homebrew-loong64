class Git-pkgs-forge < Formula
  desc "Go library and CLI for working with git forges"
  homepage "https://example.org/git-pkgs-forge"
  version "0.10.1"
  url "http://127.0.0.1:8080/brew/bottles/git-pkgs-forge--0.10.1.loongarch64.bottle.tar.gz"
  sha256 "25de22cc6f3d126f69b05cf313d5b152bd0a2462ecaec0b20d194ddfd437a72c"

  def install
    bin.install "git-pkgs-forge"
  end

  test do
    system "#{bin}/git-pkgs-forge"
  end
end
