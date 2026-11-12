class Vsearch < Formula
  desc "Versatile open-source tool for microbiome analysis"
  homepage "https://github.com/torognes/vsearch"
  url "https://github.com/torognes/vsearch/archive/refs/tags/v2.32.0.tar.gz"
  sha256 "aa6fecd099ba4970b2685e41e3a97e04f1317d12cb315870e3acdc1cd6b7fe5d"
  license any_of: ["BSD-2-Clause", "GPL-3.0-or-later"]



  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "315a0c826f3bcf65d14a52fd7f74e553cd747b11a9529b3eadf456fa1d170f90"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build

  def install
    system "./autogen.sh"
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"test.fasta").write <<~FASTA
      >U00096.2:1-70
      AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC
    FASTA
    system bin/"vsearch", "--rereplicate", "test.fasta", "--output", "output.txt"
    assert_path_exists testpath/"output.txt"
  end
end
