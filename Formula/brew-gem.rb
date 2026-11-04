class BrewGem < Formula
  desc "Install RubyGems as Homebrew formulae"
  homepage "https://github.com/sportngin/brew-gem"
  url "https://github.com/sportngin/brew-gem/archive/refs/tags/v1.3.4.tar.gz"
  sha256 "0c8b02d3bb475db2a635c9b40892f2b4106c6d721beb540215cd1dd3064742e9"
  license "MIT"
  head "https://github.com/sportngin/brew-gem.git", branch: "master"

  # Until versions exceed 2.2, the leading `v` in this regex isn't optional, as
  # we need to avoid an older `2.2` tag (a typo) while continuing to match
  # newer tags like `v1.1.1` and allowing for a future `v2.2.0` version.
  livecheck do
    url :stable
    regex(/^v(\d+(?:\.\d+)+)$/i)
  end


  uses_from_macos "ruby"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "82df328e13d3b443dc8429d9836c4c70668fc749d40a2698d7e98a833c4318af"
  end

  def install
    lib.install Dir["lib/*"]
    bin.install "bin/brew-gem"
  end

  test do
    system bin/"brew-gem", "help"
  end
end
