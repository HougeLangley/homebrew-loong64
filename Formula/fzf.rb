class Fzf < Formula
  desc "Command-line fuzzy finder written in Go"
  homepage "https://github.com/junegunn/fzf"
  url "https://github.com/junegunn/fzf/archive/refs/tags/v0.60.3.tar.gz"
  sha256 "bdef337774b0f3958644c335262053cdd3d349827856fad5e7acfb1b0b3b4c97"
  license "MIT"

  depends_on "go" => :build

  def install
    system "go", "build",
           "-ldflags", "-s -w -X main.version=#{version} -X main.revision=brew",
           "-o", bin/"fzf"
    
    prefix.install "shell"
    (prefix/"shell").install "bin/fzf-tmux"
    
    man1.install "man/man1/fzf.1", "man/man1/fzf-tmux.1"
    
    bash_completion.install "shell/completion.bash" => "fzf"
    fish_completion.install "shell/completion.fish"
    zsh_completion.install "shell/completion.zsh"
  end

  test do
    system "#{bin}/fzf", "--version"
  end
end
