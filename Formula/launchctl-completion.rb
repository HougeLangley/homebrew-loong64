class LaunchctlCompletion < Formula
  desc "Bash completion for Launchctl"
  homepage "https://github.com/CamJN/launchctl-completion"
  url "https://github.com/CamJN/launchctl-completion/archive/refs/tags/v2.0.tar.gz"
  sha256 "990499494562cedf361482c5bf9f89b3a8b6a8aee92fda4e1eadaacb96688ecd"
  license "MIT"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "b60a9b112f41b4a3692cc93ada93fcfe2c87e4dee87e998a82069e6abc518c21"
  end

  def install
    bash_completion.install "launchctl-completion.sh" => "launchctl"
  end

  test do
    assert_match "-F _launchctl",
                 shell_output("bash -c 'source #{bash_completion}/launchctl && complete -p launchctl'")
  end
end
