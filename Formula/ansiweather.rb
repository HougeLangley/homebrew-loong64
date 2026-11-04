class Ansiweather < Formula
  desc "Weather in your terminal, with ANSI colors and Unicode symbols"
  homepage "https://github.com/fcambus/ansiweather"
  url "https://github.com/fcambus/ansiweather/archive/refs/tags/1.19.1.tar.gz"
  sha256 "a3087857b014ecf46203f955c0146e6392db570a220395cfbf6b8d1587ad54c4"
  license "BSD-2-Clause"
  head "https://github.com/fcambus/ansiweather.git", branch: "master"


  uses_from_macos "bc-gh"
  uses_from_macos "jq", since: :sequoia

  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "5975d6cd86b34034f5426da25df489fd575cbea26c9a48bfe27f61f03cf5303a"
  end

  def install
    bin.install "ansiweather"
    man1.install "ansiweather.1"
  end

  test do
    assert_match "Wind", shell_output(bin/"ansiweather")
  end
end
