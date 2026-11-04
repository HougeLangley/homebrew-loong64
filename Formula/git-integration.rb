class GitIntegration < Formula
  desc "Manage git integration branches"
  homepage "https://johnkeeping.github.io/git-integration/"
  url "https://github.com/johnkeeping/git-integration/archive/refs/tags/v0.4.tar.gz"
  sha256 "b0259e90dca29c71f6afec4bfdea41fe9c08825e740ce18409cfdbd34289cc02"
  license "GPL-2.0-only"
  head "https://github.com/johnkeeping/git-integration.git", branch: "master"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "ffc7ee9f6eda2517f61ad267c73abff80f0892b3a2c17623d498b9f83f0cbb93"
  end

  def install
    (buildpath/"config.mak").write "prefix = #{prefix}"
    system "make", "install"
    system "make", "install-completion"
  end

  test do
    system "git", "init", "--initial-branch", "master"
    system "git", "config", "user.name", "BrewTestBot"
    system "git", "config", "user.email", "BrewTestBot@test.com"
    system "git", "commit", "--allow-empty", "-m", "An initial commit"
    system "git", "checkout", "-b", "branch-a", "master"
    system "git", "commit", "--allow-empty", "-m", "A commit on branch-a"
    system "git", "checkout", "-b", "branch-b", "master"
    system "git", "commit", "--allow-empty", "-m", "A commit on branch-b"
    system "git", "checkout", "master"
    system "git", "integration", "--create", "integration"
    system "git", "integration", "--add", "branch-a"
    system "git", "integration", "--add", "branch-b"
    system "git", "integration", "--rebuild"
  end
end
