class Goto < Formula
  desc "Bash tool for navigation to aliased directories with auto-completion"
  homepage "https://iridakos.com/programming/2019/04/10/shell-navigation-with-autocomplete"
  url "https://github.com/iridakos/goto/archive/refs/tags/v2.0.0.tar.gz"
  sha256 "460fe3994455501b50b2f771f999ace77ade295122e90e959084047dbfb1f0dc"
  license "MIT"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "84e03e4670d271217a823a1dfb918dcca35eac0f047672ded2c211005e6a66fe"
  end

  def install
    bash_completion.install "goto.sh"
  end

  test do
    assert_match "-F _complete_goto_bash",
      shell_output("bash -c 'source #{bash_completion}/goto.sh && complete -p goto'")
  end
end
