class Vcftools < Formula
  desc "Tools for working with VCF files"
  homepage "https://vcftools.github.io/"
  url "https://github.com/vcftools/vcftools/releases/download/v0.1.17/vcftools-0.1.17.tar.gz"
  sha256 "b9e0e1c3e86533178edb35e02c6c4de9764324ea0973bebfbb747018c2d2a42c"
  license "LGPL-3.0-only"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "0756f598b2be1564f3fe7f26c1e4f6b2d7c8c2df13ad09feb9c20dfd531d9002"
  end


  depends_on "pkgconf" => :build
  depends_on "htslib"

  on_linux do
    depends_on "zlib-ng-compat"
  end

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--disable-silent-rules",
                          "--with-pmdir=lib/perl5/site_perl",
                          *std_configure_args
    system "make", "install"

    bin.env_script_all_files(libexec/"bin", PERL5LIB: lib/"perl5/site_perl")
  end

  test do
    (testpath/"test.vcf").write <<~EOS
      ##fileformat=VCFv4.0
      #CHROM	POS	ID	REF	ALT	QUAL	FILTER	INFO
      1	1	.	A	C	10	PASS	.
    EOS

    system bin/"vcf-validator", "test.vcf"
  end
end
