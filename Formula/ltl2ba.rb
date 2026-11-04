class Ltl2ba < Formula
  desc "Translate LTL formulae to Buchi automata"
  homepage "https://lsv.ens-paris-saclay.fr/~gastin/ltl2ba/"
  url "https://lsv.ens-paris-saclay.fr/~gastin/ltl2ba/ltl2ba-1.3.tar.gz"
  mirror "https://pkg.freebsd.org/ports-distfiles/ltl2ba-1.3.tar.gz"
  sha256 "912877cb2929cddeadfd545a467135a2c61c507bbd5ae0edb695f8b5af7ce9af"
  license "GPL-2.0-or-later"

  livecheck do
    url "https://lsv.ens-paris-saclay.fr/~gastin/ltl2ba/download.php", post_form: {
      getltl2ba: "Get LTL2BA",
    }
    regex(/href=.*?ltl2ba[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "58200e008a5bf91304483789c535aecfd7820b4dfc869b1ee83f8bc5568673bd"
  end

  def install
    system "make"
    bin.install "ltl2ba"
  end

  test do
    assert_match ":: (p) -> goto accept_all", shell_output("#{bin}/ltl2ba -f 'p if p ∈ w(0)'")
  end
end
