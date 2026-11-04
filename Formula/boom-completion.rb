class BoomCompletion < Formula
  desc "Bash and Zsh completion for Boom"
  homepage "https://zachholman.com/boom/"
  url "https://github.com/holman/boom/archive/refs/tags/v0.5.0.tar.gz"
  sha256 "d107accf1fb84d9c245bb25383486179605d3b397c439c2f4690341283b0b2dd"
  license "MIT"
  head "https://github.com/holman/boom.git", branch: "master"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "dc9978de42e5e24374a40c79405ce846ba1f9dfe9f506acff5859ee254a8133b"
  end

  def install
    bash_completion.install "completion/boom.bash" => "boom"
    zsh_completion.install "completion/boom.zsh" => "_boom"
  end

  test do
    assert_match "-F _boom_complete",
      shell_output("bash -c 'source #{bash_completion}/boom && complete -p boom'")
  end
end
