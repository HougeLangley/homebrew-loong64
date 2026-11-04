class Freesasa < Formula
  desc "Solvent Accessible Surface Area calculations"
  homepage "https://freesasa.github.io/"
  url "https://github.com/mittinatten/freesasa/archive/refs/tags/2.1.3.tar.gz"
  sha256 "dc4fe377352569299d69329d9ded2f141e527da325960b20d2e30b5335c2b3ff"
  license "MIT"


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "c1685b5d3a03787a2946466b16dc340e9444592c51a2dab6f6d139a6c77d9115"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "pkgconf" => :build
  depends_on "json-c"

  uses_from_macos "libxml2"

  def install
    system "autoreconf", "--force", "--install", "--verbose"
    system "./configure", "--disable-silent-rules", *std_configure_args
    system "make"
    system "make", "install"
    pkgshare.install "tests/data"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/freesasa --version")

    output = shell_output("#{bin}/freesasa #{pkgshare}/data/3bkr.pdb")
    assert_match "RESULTS", output
  end
end
