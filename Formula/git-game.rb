class GitGame < Formula
  desc "Game for git to guess who made which commit"
  homepage "https://github.com/jsomers/git-game"
  url "https://github.com/jsomers/git-game/archive/refs/tags/1.3.tar.gz"
  sha256 "6670c73c2ffe2bc2255566c88f26763100bf0b24a94d3fe10d255712d2a8809e"
  license "MIT"


  uses_from_macos "ruby"

  bottle do
    rebuild 2
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "56917fda27c36fc7dc0a00e502d4f3fc6d16fece5212bc11743bd9f218efab62"
  end

  def install
    bin.install "git-game"
  end

  test do
    system "git", "game", "help"
  end
end
