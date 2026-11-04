class Seqtk < Formula
  desc "Toolkit for processing sequences in FASTA/Q formats"
  homepage "https://github.com/lh3/seqtk"
  url "https://github.com/lh3/seqtk/archive/refs/tags/v1.5.tar.gz"
  sha256 "384aa1e3cecf4f70403839d586cbb29d469b7c6f773a64bc5af48a6e4b8220a6"
  license "MIT"

  bottle do
    rebuild 2
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "71d53735981efda1c29ec157f4b5b239065892a9027efd9bddc9509c414bc652"
  end


  on_linux do
    depends_on "zlib-ng-compat"
  end


  def install
    system "make"
    bin.install "seqtk"
  end

  test do
    (testpath/"test.fasta").write <<~FASTA
      >U00096.2:1-70
      AGCTTTTCATTCTGACTGCAACGGGCAATATGTCT
      CTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC
    FASTA
    assert_match "TCTCTG", shell_output("#{bin}/seqtk seq test.fasta")
  end
end
