class Bwa < Formula
  desc "Burrow-Wheeler Aligner for pairwise alignment of DNA"
  homepage "https://github.com/lh3/bwa"
  url "https://github.com/lh3/bwa/archive/refs/tags/v0.7.19.tar.gz"
  sha256 "cdff5db67652c5b805a3df08c4e813a822c65791913eccfb3cf7d528588f37bc"
  license all_of: ["GPL-3.0-or-later", "MIT"]
  head "https://github.com/lh3/bwa.git", branch: "master"


  on_linux do
    depends_on "zlib-ng-compat"
  end

  on_arm do
    depends_on "sse2neon" => :build
  end

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "eda3e7980882fa41756d6743b7a60a218f8cdcf0cc2903a75cde8d9a23ebfca6"
  end

  def install
    system "make"

    # "make install" requested 26 Dec 2017 https://github.com/lh3/bwa/issues/172
    bin.install "bwa"
    man1.install "bwa.1"
  end

  test do
    (testpath/"test.fasta").write ">0\nAGATGTGCTG\n"
    system bin/"bwa", "index", "test.fasta"
    assert_path_exists testpath/"test.fasta.bwt"
    assert_match "AGATGTGCTG", shell_output("#{bin}/bwa mem test.fasta test.fasta")
  end
end
