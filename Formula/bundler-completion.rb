class BundlerCompletion < Formula
  desc "Bash completion for Bundler"
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
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "27d21d2e7722f7767fd06fc021ec842dd01bee7b805880bc9499688d84347982"
  end

  def install
    bash_completion.install "completion-bundle" => "bundler"
  end

  test do
    assert_match "-F __bundle",
      shell_output("bash -c 'source #{bash_completion}/bundler && complete -p bundle'")
  end
end
