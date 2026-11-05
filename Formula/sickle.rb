class Sickle < Formula
  desc "Windowed adaptive trimming for FASTQ files using quality"
  homepage "https://github.com/najoshi/sickle"
  url "https://github.com/najoshi/sickle/archive/refs/tags/v1.33.tar.gz"
  sha256 "eab271d25dc799e2ce67c25626128f8f8ed65e3cd68e799479bba20964624734"
  license "MIT"

  bottle do
    rebuild 2
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "fc1e961be79ae0a2ef6bc687c96471ecd7ac4f4c5f3e99503e8610a642d78b5a"
  end


  on_linux do
    depends_on "zlib-ng-compat"
  end


  def install
    system "make"
    bin.install "sickle"
  end

  test do
    (testpath/"test.fastq").write <<~FASTQ
      @U00096.2:1-70
      AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC
      +
      IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII0000000000
    FASTQ
    cmd = "#{bin}/sickle se -f test.fastq -t sanger -o /dev/stdout"
    assert_equal "GTGTC\n", shell_output(cmd).lines[1][-6..]
  end
end
