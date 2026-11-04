class GitFresh < Formula
  desc "Utility to keep git repos fresh"
  homepage "https://github.com/imsky/git-fresh"
  url "https://github.com/imsky/git-fresh/archive/refs/tags/v1.13.0.tar.gz"
  sha256 "7043aaf2bf66dade7d06ebcf96e5d368c4910c002b7b00962bd2bd24490ce2dc"
  license "MIT"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "0565fba1a138ac6db3e273f2d87e4845c51d0b208b4887080a2d6f0d67f96b15"
  end

  def install
    system "./install.sh", bin
    man1.install "git-fresh.1"
  end

  test do
    ENV["GIT_CONFIG_GLOBAL"] = "#{testpath}/.gitconfig"

    system "git", "config", "--global", "init.defaultBranch", "master"
    system bin/"git-fresh", "-T"
  end
end
