class Bcal < Formula
  desc "Storage conversion and expression calculator"
  homepage "https://github.com/jarun/bcal"
  url "https://github.com/jarun/bcal/archive/refs/tags/v2.6.tar.gz"
  sha256 "bac318405221f2f88d374683549338515b070ca7491497eda2ac9c17bcbb0458"
  license "GPL-3.0-or-later"

  livecheck do
    url :stable
    strategy :github_latest
  end


  on_linux do
    depends_on "readline"
  end

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "dc0dffad709ea753fedd7279475ce093091a63badd8200d6085997169971c34a"
  end

  def install
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    assert_match "9333353817", shell_output("#{bin}/bcal '56 gb / 6 + 4kib * 5 + 4 B'")
  end
end
