class RnaStar < Formula
  desc "RNA-seq aligner"
  homepage "https://github.com/alexdobin/STAR"
  url "https://github.com/alexdobin/STAR/archive/refs/tags/2.7.11b.tar.gz"
  version "2.7.11b"
  sha256 "3f65305e4112bd154c7e22b333dcdaafc681f4a895048fa30fa7ae56cac408e7"
  license all_of: ["MIT", "BSD-2-Clause"]

  bottle do
    rebuild 2
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "090f6572ed54851bea389b9986acdb1915755152ea493635710d8e20e4b4a0ec"
  end


  uses_from_macos "vim" => :build # needed for xxd

  on_macos do
    depends_on "libomp"
  end

  on_linux do
    depends_on "zlib-ng-compat"
  end


  def install
    args = ["CXXFLAGS_SIMD="]
    args << "CXXFLAGSextra=-D'COMPILE_FOR_MAC'" if OS.mac?

    cd "source" do
      system "make", "STAR", *args
      bin.install "STAR"
    end
  end

  test do
    (testpath/"test.fasta").write <<~FASTA
      >U00096.2:1-70
      AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC
    FASTA
    out = shell_output("#{bin}/STAR --runMode genomeGenerate --genomeFastaFiles test.fasta --genomeSAindexNbases 2")
    assert_match "finished successfully", out
  end
end
