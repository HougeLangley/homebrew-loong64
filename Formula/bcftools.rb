class Bcftools < Formula
  desc "Tools for BCF/VCF files and variant calling from samtools"
  homepage "https://www.htslib.org/"
  url "https://github.com/samtools/bcftools/releases/download/1.24/bcftools-1.24.tar.bz2"
  sha256 "8caddc22610ee2851666047c859bb91da0c1e32d0c2ec553db6f153ad130e46f"
  # The bcftools source code is MIT/Expat-licensed, but when it is configured
  # with --enable-libgsl the resulting executable is GPL-licensed.
  license "GPL-3.0-or-later"

  livecheck do
    url :stable
    strategy :github_latest
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "413dfe0973afa05db1f46a79e19220f3aab78e45616b16961be73faa25217291"
  end

  depends_on "gsl"
  depends_on "htslib"

  deny_network_access!

  def install
    system "./configure", "--prefix=#{prefix}",
                          "--with-htslib=#{formula_opt_prefix("htslib")}",
                          "--enable-libgsl"
    system "make", "install"
    pkgshare.install "test/query.vcf"
  end

  test do
    output = shell_output("#{bin}/bcftools stats #{pkgshare}/query.vcf")
    assert_match "number of SNPs:\t3", output
    assert_match "fixploidy", shell_output("#{bin}/bcftools plugin -l")
  end
end
