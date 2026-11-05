class Spaceship < Formula
  desc "Zsh prompt for Astronauts"
  homepage "https://spaceship-prompt.sh/"
  url "https://github.com/spaceship-prompt/spaceship-prompt/archive/refs/tags/v4.22.6.tar.gz"
  sha256 "02da1413520241668141041f82284410dad5d3b4379a4d21b346ee206ee5f2be"
  license "MIT"
  head "https://github.com/spaceship-prompt/spaceship-prompt.git", branch: "master"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "523ff4a5cb8573fa00ccbd5d98c1158672273dbac1a5c2576c75d64d2589fa9e"
  end



  depends_on "zsh-async"
  uses_from_macos "zsh" => :test

  def install
    system "make", "compile"
    prefix.install Dir["*"]
  end

  def caveats
    <<~EOS
      To activate Spaceship, add the following line to ~/.zshrc:
        source "#{opt_prefix}/spaceship.zsh"
      If your .zshrc sets ZSH_THEME, remove that line.
    EOS
  end

  test do
    # sourcing exits non-zero when `zcompile` cannot write beside the read-only keg, so check the prompt hook instead
    assert_match "SUCCESS",
      shell_output("zsh -fc '. #{opt_prefix}/spaceship.zsh 2>/dev/null; " \
                   "(( ${precmd_functions[(I)prompt_spaceship_precmd]} )) && echo SUCCESS'")
  end
end
