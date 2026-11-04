class Nsnake < Formula
  desc "Classic snake game with textual interface"
  homepage "https://github.com/alexdantas/nSnake"
  url "https://downloads.sourceforge.net/project/nsnake/GNU-Linux/nsnake-3.0.1.tar.gz"
  sha256 "e0a39e0e188a6a8502cb9fc05de3fa83dd4d61072c5b93a182136d1bccd39bb9"
  license "GPL-3.0-or-later"
  head "https://github.com/alexdantas/nSnake.git", branch: "master"


  uses_from_macos "ncurses"

  bottle do
    rebuild 2
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "ae12c25b882823376c4ba9f492f4730639a9916ac25f597a0e595fb9bfa766b9"
  end

  def install
    system "make", "install", "PREFIX=#{prefix}"

    # No need for Linux desktop
    rm_r(share/"applications")
    rm_r(share/"icons")
    rm_r(share/"pixmaps")
  end

  test do
    assert_match "nsnake v#{version} ", shell_output("#{bin}/nsnake -v")
  end
end
