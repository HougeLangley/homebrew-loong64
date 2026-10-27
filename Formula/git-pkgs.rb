class Git-pkgs < Formula
  desc "A git subcommand for analyzing package/dependency usage in git repositories over time"
  homepage "https://example.org/git-pkgs"
  version "0.21.0"
  url "http://127.0.0.1:8080/brew/bottles/git-pkgs--0.21.0.loongarch64.bottle.tar.gz"
  sha256 "72b4127c11a11dc48d24faf17bc61d2c9181033725acd9126aef2592ae7cfd6f"

  def install
    bin.install "git-pkgs"
  end

  test do
    system "#{bin}/git-pkgs"
  end
end
