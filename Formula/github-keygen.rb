class GithubKeygen < Formula
  desc "Bootstrap GitHub SSH configuration"
  homepage "https://github.com/dolmen/github-keygen"
  url "https://github.com/dolmen/github-keygen/archive/refs/tags/v1.401.tar.gz"
  sha256 "0feb346de7927a3bcacadf2122b333041bb7b21b8262230265dc49a2d0f0b7ef"
  license "GPL-3.0-or-later"
  head "https://github.com/dolmen/github-keygen.git", branch: "release"


  uses_from_macos "perl"

  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "6d7548a572f7ea50fb62d55d550577d0f47d946ae97d7e2f83a2d236338532d8"
  end

  def install
    bin.install "github-keygen"
  end

  test do
    system bin/"github-keygen"
  end
end
