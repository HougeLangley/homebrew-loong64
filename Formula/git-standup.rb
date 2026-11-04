class GitStandup < Formula
  desc "Git extension to generate reports for standup meetings"
  homepage "https://github.com/nilbuild/git-standup"
  url "https://github.com/nilbuild/git-standup/archive/refs/tags/2.3.2.tar.gz"
  sha256 "48d5aaa3c585037c950fa99dd5be8a7e9af959aacacde9fe94143e4e0bfcd6ba"
  license "MIT"
  head "https://github.com/nilbuild/git-standup.git", branch: "master"


  conflicts_with "git-extras", because: "both install `git-standup` binaries"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "a76ef939f678a8baaaf61b25c0dae42e521b7beee35f1c17eaebe31971a3a1f1"
  end

  def install
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    system "git", "init"
    (testpath/"test").write "test"
    system "git", "add", testpath/"test"
    system "git", "commit", "--message", "test"
    system "git", "standup"
  end
end
