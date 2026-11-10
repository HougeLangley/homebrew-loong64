class BoomCompletion < Formula
  desc "Bash and Zsh completion for Boom"
  homepage "https://zachholman.com/boom/"
  url "https://github.com/holman/boom/archive/refs/tags/v0.5.0.tar.gz"
  sha256 "d107accf1fb84d9c245bb25383486179605d3b397c439c2f4690341283b0b2dd"
  license "MIT"
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "51d5983142d7df2a547556759e1cd6db5d10171250d272bdda7df533daccd2c5"
  end

  head "https://github.com/holman/boom.git", branch: "master"



  def install
    bash_completion.install "completion/boom.bash" => "boom"
    zsh_completion.install "completion/boom.zsh" => "_boom"
  end

  test do
    assert_match "-F _boom_complete",
      shell_output("bash -c 'source #{bash_completion}/boom && complete -p boom'")
  end
end
