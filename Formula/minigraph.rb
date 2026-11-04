class Minigraph < Formula
  desc "Proof-of-concept seq-to-graph mapper and graph generator"
  homepage "https://lh3.github.io/minigraph"
  url "https://github.com/lh3/minigraph/archive/refs/tags/v0.21.tar.gz"
  sha256 "4272447393f0ae1e656376abe144de96cbafc777414d4c496f735dd4a6d3c06a"
  license "MIT"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end


  on_linux do
    depends_on "zlib-ng-compat"
  end

  bottle do
    rebuild 2
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "e3c3a76192aaac83bb78da92bfeb9ef7f302e9484b26fba6215c3d7b61c2dc28"
  end

  def install
    inreplace "Makefile" do |s|
      cflags = s.get_make_var("CFLAGS").split
      cflags.delete("-msse4") { |flag| "Remove inreplace for #{flag}!" }
      s.change_make_var! "CFLAGS", cflags.join(" ")
    end

    system "make"
    bin.install "minigraph"
    pkgshare.install "test"
  end

  test do
    cp_r pkgshare/"test/.", testpath
    output = shell_output("#{bin}/minigraph MT-human.fa MT-orangA.fa 2>&1")
    assert_match "mapped 1 sequences", output
  end
end
