class Gimme < Formula
  desc "Shell script to install any Go version"
  homepage "https://github.com/travis-ci/gimme"
  url "https://github.com/travis-ci/gimme/archive/refs/tags/v1.5.6.tar.gz"
  sha256 "50c42ec01505bee0e5b60165a0f577fe1e08fe9278fe3fe4b073c521f781c61e"
  license "MIT"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "66b69d41eae11f8c14849d03e271987d76f9e66e9eace68f944cf7d48200506e"
  end

  def install
    bin.install "gimme"
  end

  test do
    system bin/"gimme", "-l"
  end
end
