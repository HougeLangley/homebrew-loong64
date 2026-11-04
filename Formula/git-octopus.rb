class GitOctopus < Formula
  desc "Continuous merge workflow"
  homepage "https://github.com/lesfurets/git-octopus"
  url "https://github.com/lesfurets/git-octopus/archive/refs/tags/v1.4.tar.gz"
  sha256 "e2800eea829c6fc74da0d3f3fcb3f7d328d1ac8fbb7b2eca8c651c0c903a50c3"
  license "LGPL-3.0-only"


  deprecate! date: "2025-12-14", because: :repo_archived
  disable! date: "2026-12-14", because: :repo_archived

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "d7b59af7d033892323a56d3de6d4c1af129f66586ec425cfb96d2d4066c34319"
  end

  def install
    system "make", "build"
    bin.install "bin/git-octopus", "bin/git-conflict", "bin/git-apply-conflict-resolution"
    man1.install "doc/git-octopus.1", "doc/git-conflict.1"
  end

  test do
    system "git", "init"
    touch "homebrew"
    system "git", "add", "."
    system "git", "commit", "--message", "brewing"

    assert_empty shell_output("#{bin}/git-octopus 2>&1").strip
  end
end
