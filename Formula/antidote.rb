class Antidote < Formula
  desc "Plugin manager for zsh, inspired by antigen and antibody"
  homepage "https://antidote.sh/"
  url "https://github.com/mattmc3/antidote/archive/refs/tags/v2.3.0.tar.gz"
  sha256 "c8b4f85d01c8c8715f279a8fed075a1e03e755e914bf1fd98688f24156fc110e"
  license "MIT"


  uses_from_macos "zsh"

  # `test do` block clones a plugin from GitHub
  allow_network_access! :test

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "322e458cde224568f797ea9da6c19338b37429da879184d179f2ea25f7bdc608"
  end

  def install
    pkgshare.install "antidote"
    pkgshare.install "antidote.zsh"
    pkgshare.install "functions"
    man.install "man/man1"
  end

  def caveats
    <<~EOS
      To activate antidote, add the following to your ~/.zshrc:
        source #{opt_pkgshare}/antidote.zsh
    EOS
  end

  test do
    (testpath/".zshrc").write <<~SHELL
      export GIT_TERMINAL_PROMPT=0
      export ANTIDOTE_HOME=~/.zplugins
      source #{pkgshare}/antidote.zsh
    SHELL

    system "zsh", "--login", "-i", "-c", "antidote install rupa/z"
    assert_equal (testpath/".zsh_plugins.txt").read, "rupa/z\n"
    assert_path_exists testpath/".zplugins/github.com/rupa/z/z.sh"
  end
end
