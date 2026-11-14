class OpenTyrian < Formula
  desc "Open-source port of Tyrian"
  homepage "https://github.com/opentyrian/opentyrian"
  url "https://github.com/opentyrian/opentyrian/archive/refs/tags/v2.1.20260913.tar.gz"
  sha256 "dbcd96383d4fa571137242c36bd7eca054cf5a08a9bf2eec15ef230d6e60680d"
  license "GPL-2.0-or-later"
  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "66faba827ec7ec5f1cf5c7e869957ee5e8af1f881cf3625cdf6f00fee91e64e5"
  end

  head "https://github.com/opentyrian/opentyrian.git", branch: "master"



  depends_on "pkgconf" => :build
  depends_on "sdl2-compat"
  depends_on "sdl2_net"

  resource "homebrew-test-data" do
    url "https://www.camanis.net/tyrian/tyrian21.zip"
    sha256 "7790d09a2a3addcd33c66ef063d5900eb81cc9c342f4807eb8356364dd1d9277"
  end

  def install
    datadir = pkgshare/"data"
    datadir.install resource("homebrew-test-data")
    system "make", "TYRIAN_DIR=#{datadir}"
    bin.install "opentyrian"
  end

  def caveats
    "Save games will be put in ~/.opentyrian"
  end

  test do
    system bin/"opentyrian", "--help"
  end
end
