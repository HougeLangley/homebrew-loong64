class GemCompletion < Formula
  desc "Bash completion for gem"
  homepage "https://github.com/mernen/completion-ruby"
  url "https://github.com/mernen/completion-ruby/archive/refs/tags/v1.0.3.tar.gz"
  sha256 "cbcd002bba2a43730cff54f5386565917913d9dec16dcd89345fbe298fe4316b"
  license "MIT"
  version_scheme 1
  head "https://github.com/mernen/completion-ruby.git", branch: "main"

  livecheck do
    formula "ruby-completion"
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "8b8b850b2078eda619a976c1f294d91c773e4558eda909f0a96c9c82cb6744b6"
  end

  def install
    bash_completion.install "completion-gem" => "gem"
  end

  test do
    assert_match "-F __gem",
      shell_output("bash -c 'source #{bash_completion}/gem && complete -p gem'")
  end
end
