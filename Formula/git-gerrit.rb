class GitGerrit < Formula
  desc "Gerrit code review helper scripts"
  homepage "https://github.com/fbzhong/git-gerrit"
  url "https://github.com/fbzhong/git-gerrit/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "433185315db3367fef82a7332c335c1c5e0b05dabf8d4fbeff9ecf6cc7e422eb"
  license "BSD-3-Clause"
  head "https://github.com/fbzhong/git-gerrit.git", branch: "master"


  conflicts_with "gerrit-tools", because: "both install `gerrit-cherry-pick` binaries"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "787002ebf9ad4c8afb2487821da675bb1874af1bf310feea10c0b0cb7e4d91fd"
  end

  def install
    prefix.install "bin"
    bash_completion.install "completion/git-gerrit-completion.bash" => "git-gerrit"
  end

  test do
    system "git", "init"
    system "git", "gerrit", "help"
  end
end
