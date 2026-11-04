class CondaZshCompletion < Formula
  desc "Zsh completion for conda"
  homepage "https://github.com/conda-incubator/conda-zsh-completion"
  url "https://github.com/conda-incubator/conda-zsh-completion/archive/refs/tags/v0.11.tar.gz"
  sha256 "584d5817e276f01f5d789e01ba5c6688667b38d3c9f4ad2cd735a9901e27aa33"
  license "WTFPL"
  head "https://github.com/conda-incubator/conda-zsh-completion.git", branch: "main"


  uses_from_macos "zsh" => :test

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "350f7642a3309f3ae88b5879782437c698c64ef335151f994113dfdd7c68cc03"
  end

  def install
    zsh_completion.install "_conda"
  end

  test do
    assert_match(/^_conda \(\) \{/,
      shell_output("zsh -c 'fpath=(#{zsh_completion} $fpath); autoload _conda; which _conda'"))
  end
end
