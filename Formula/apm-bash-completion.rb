class ApmBashCompletion < Formula
  desc "Completion for Atom Package Manager"
  homepage "https://github.com/vigo/apm-bash-completion"
  url "https://github.com/vigo/apm-bash-completion/archive/refs/tags/1.0.0.tar.gz"
  sha256 "1043a7f19eabe69316ea483830fb9f78d6c90853aaf4dd7ed60007af7f0d6e9d"
  license "MIT"


  deprecate! date: "2025-04-27", because: :repo_archived
  disable! date: "2026-04-27", because: :repo_archived

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "3260f3cb5ba3e8b6c7abd8b63d82289d3bf609c912ad1f84f439e5af0ca3508d"
  end

  def install
    bash_completion.install "apm"
  end

  test do
    assert_match "-F __apm",
      shell_output("bash -c 'source #{bash_completion}/apm && complete -p apm'")
  end
end
