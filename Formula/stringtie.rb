class Stringtie < Formula
  desc "Transcript assembly and quantification for RNA-Seq"
  homepage "https://github.com/gpertea/stringtie"
  url "https://github.com/gpertea/stringtie/archive/refs/tags/v3.0.3.tar.gz"
  sha256 "cb473760912a7a23b09232171902b57a973ca791510c526a7a60f23616008ec8"
  license "MIT"
  revision 1
  head "https://github.com/gpertea/stringtie.git", branch: "master"

  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "56f3405bf004ed12ddaf62d78e7728a45c40b606f016eb4849d6f60c462ba931"
  end



  depends_on "htslib"

  resource "homebrew-test", :test do
    url "https://github.com/gpertea/stringtie/raw/test_data/tests.tar.gz"
    sha256 "815a31b2664166faa59cdd25f0dc2da3d3dcb13e69ee644abb972a93d374ac10"
  end

  def install
    args = [
      "HTSLIB=#{formula_opt_lib("htslib")}",
      "LIBS=-L#{formula_opt_lib("htslib")} -lhts -lm",
    ]
    system "make", "release", *args
    bin.install "stringtie"
  end

  test do
    resource("homebrew-test").stage testpath
    assert_match version.to_s, shell_output("#{bin}/stringtie --version")
    system bin/"stringtie", "-o", "short_reads.out.gtf", "short_reads.bam"
    assert_path_exists "short_reads.out.gtf"
  end
end
