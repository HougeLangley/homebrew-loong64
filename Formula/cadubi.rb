class Cadubi < Formula
  desc "Creative ASCII drawing utility"
  homepage "https://github.com/statico/cadubi/"
  url "https://github.com/statico/cadubi/archive/refs/tags/v1.3.4.tar.gz"
  sha256 "624f85bb16d8b0bc392d761d1121828d09cfc79b3ded5b1220e9b4262924a1a0"
  license "MIT"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "f353bbae17c1dc269d693df58c9226c45fa5b2d740a435b1ee1ac2d1fb464915"
  end

  def install
    inreplace "cadubi", "$Bin/help.txt", "#{doc}/help.txt"
    bin.install "cadubi"
    doc.install "help.txt"
    man1.install "cadubi.1"
  end

  test do
    output = pipe_output("script -q /dev/null #{bin}/cadubi -v", "cat")
    assert_match "cadubi (Creative ASCII Drawing Utility By Ian) #{version}", output
  end
end
