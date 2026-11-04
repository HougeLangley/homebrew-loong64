class Foma < Formula
  desc "Finite-state compiler and C library"
  homepage "https://github.com/mhulden/foma"
  url "https://github.com/mhulden/foma/archive/refs/tags/v0.10.0.tar.gz"
  sha256 "32fff2bd0a8338716adfee71505277d8562dabd48be9bf15620c38b15c8c404e"
  license "Apache-2.0"
  revision 1

  livecheck do
    url "https://raw.githubusercontent.com/mhulden/foma/refs/heads/master/foma/CHANGELOG"
    regex(/v?(\d+(?:\.\d+)+)/i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "b455d46566058c61608df2b7dee61f4ddd26312a1cd59ff5355eb81cb8428866"
  end

  depends_on "bison" => :build # requires Bison 3.0+
  depends_on "cmake" => :build
  depends_on "pkgconf" => :build

  uses_from_macos "flex" => :build

  on_linux do
    depends_on "readline"
    depends_on "zlib-ng-compat"
  end

  conflicts_with "freeling", because: "freeling ships its own copy of foma"

  def install
    system "cmake", "-S", "foma", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    # Source: https://code.google.com/archive/p/foma/wikis/ExampleScripts.wiki
    (testpath/"toysyllabify.script").write <<~EOS
      define V [a|e|i|o|u];
      define Gli [w|y];
      define Liq [r|l];
      define Nas [m|n];
      define Obs [p|t|k|b|d|g|f|v|s|z];

      define Onset (Obs) (Nas) (Liq) (Gli); # Each element is optional.
      define Coda  Onset.r;                 # Is mirror image of onset.

      define Syllable Onset V Coda;
      regex Syllable @> ... "." || _ Syllable;

      apply down> abrakadabra
    EOS

    system bin/"foma", "-f", "toysyllabify.script"
  end
end
