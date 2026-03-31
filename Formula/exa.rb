class Exa < Formula
  desc "Modern replacement for 'ls'"
  homepage "https://the.exa.website"
  url "https://github.com/ogham/exa/archive/refs/tags/v0.10.1.tar.gz"
  sha256 "ff0fa0bfc4edef8bdbce3a685edd09b2ebdac82411e547497fb4f4aeb94c240c"
  license "MIT"
  head "https://github.com/ogham/exa.git", branch: "master"

  depends_on "rust" => :build

  uses_from_macos "zlib"

  def install
    system "cargo", "install", *std_cargo_args

    bash_completion.install "completions/bash/exa" => "exa"
    zsh_completion.install  "completions/zsh/_exa" => "_exa"
    fish_completion.install "completions/fish/exa.fish" => "exa.fish"

    man1.install Dir["man/*"]
  end

  test do
    system bin/"exa", "--version"
  end
end
