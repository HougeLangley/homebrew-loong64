class Kraken2 < Formula
  desc "Taxonomic sequence classification system"
  homepage "https://github.com/DerrickWood/kraken2"
  url "https://github.com/DerrickWood/kraken2/archive/refs/tags/2.17.2.tar.gz"
  sha256 "84ff95cd6d8a4c9e93ab6bf1d9b3892099baaefb0277bcf2edc3eb4948566035"
  license "MIT"
  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "16afd57d3ae5cccfa17c7694673bf82393011f2eb7a1f98e3fb592bfbbc8fc9e"
  end

  head "https://github.com/DerrickWood/kraken2.git", branch: "master"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end



  depends_on "gperftools"
  depends_on "wget"

  uses_from_macos "perl"
  uses_from_macos "python"
  uses_from_macos "rsync"

  on_macos do
    depends_on "libomp"
  end

  on_linux do
    depends_on "zlib-ng-compat"
  end

  # Link `merge` against `omp_hack.o` for builds without OpenMP
  patch do
    url "https://github.com/DerrickWood/kraken2/commit/01fb1d90167c720b6ecab3db707587d6406c8df4.patch?full_index=1"
    sha256 "5a09c4b99b8c656ed4c00c0d40670a63525a99bb3a2abbb60019991da8b17cbd"
    type :unofficial
    resolves "https://github.com/DerrickWood/kraken2/pull/1041"
  end

  def install
    system "./install_kraken2.sh", libexec
    %w[k2 kraken2 kraken2-build kraken2-inspect].each do |f|
      bin.install_symlink libexec/f
    end
    pkgshare.install "data"
  end

  test do
    cp pkgshare/"data/Lambda.fa", testpath
    system bin/"kraken2-build", "--add-to-library", "Lambda.fa", "--db", "testdb"
    assert_path_exists "testdb"
  end
end
