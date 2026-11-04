class Screenfetch < Formula
  desc "Generate ASCII art with terminal, shell, and OS info"
  homepage "https://github.com/KittyKatt/screenFetch"
  url "https://github.com/KittyKatt/screenFetch/archive/refs/tags/v3.9.9.tar.gz"
  sha256 "65ba578442a5b65c963417e18a78023a30c2c13a524e6e548809256798b9fb84"
  license "GPL-3.0-or-later"
  head "https://github.com/KittyKatt/screenFetch.git", branch: "master"


  # `screenfetch` contains references to `/usr/local` that
  # are erroneously relocated in non-default prefixes.
  pour_bottle? only_if: :default_prefix

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "c700d95a09234f1dd8e8845bfabc2419ba2528e96c3969aa45036674fdabdaee"
  end

  def install
    bin.install "screenfetch-dev" => "screenfetch"
    man1.install "screenfetch.1"
  end

  test do
    system bin/"screenfetch"
  end
end
