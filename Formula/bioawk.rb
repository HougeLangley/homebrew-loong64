class Bioawk < Formula
  desc "AWK modified for biological data"
  homepage "https://github.com/lh3/bioawk"
  url "https://github.com/lh3/bioawk/archive/refs/tags/v1.0.tar.gz"
  sha256 "5cbef3f39b085daba45510ff450afcf943cfdfdd483a546c8a509d3075ff51b5"
  license "HPND"


  uses_from_macos "bison" => :build

  on_linux do
    depends_on "zlib-ng-compat"
  end

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "569f2c2f4b93824c23c33949e2ce0f14ef48b8742b8e995c0ffcb8d0186733f8"
  end

  def install
    # Fix make: *** No rule to make target `ytab.h', needed by `b.o'.
    ENV.deparallelize

    system "make"
    bin.install "bioawk"
    man1.install "awk.1" => "bioawk.1"
  end

  test do
    (testpath/"test.fasta").write <<~EOS
      >U00096.2:1-70
      AGCTTTTCATTCTGACTGCAACGGGCAATATGTCT
      CTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC
    EOS
    cmd = "#{bin}/bioawk -cfastx '{print length($seq)}' test.fasta"
    assert_equal "70", shell_output(cmd).chomp
  end
end
