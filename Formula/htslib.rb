class Htslib < Formula
  desc "C library for high-throughput sequencing data formats"
  homepage "https://www.htslib.org/"
  url "https://github.com/samtools/htslib/releases/download/1.24/htslib-1.24.tar.bz2"
  sha256 "28a8de191381c7a97a35675ceac76fa1ea95e7b678d6a2e9d600a7874e4077de"
  license all_of: ["MIT", "BSD-3-Clause"]
  revision 1
  compatibility_version 1

  livecheck do
    url :stable
    strategy :github_latest
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "1a45298fca95e7edffad63ff0509856524845c94240894399469645124c6debf"
  end

  depends_on "libdeflate"
  depends_on "xz"

  uses_from_macos "bzip2"
  uses_from_macos "curl"

  on_linux do
    depends_on "openssl@4"
    depends_on "zlib-ng-compat"
  end

  deny_network_access!

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "buildaux/#{cf}", "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}", "dist/#{cf}"].each do |rel|
        src = "/usr/share/libtool/build-aux/#{cf}"
        dest = buildpath/rel
        if dest.exist? && File.exist?(src)
          File.chmod(0644, dest)
          cp src, dest
        end
      end
    end

    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--enable-libcurl", "--with-libdeflate", *std_configure_args
    system "make", "install"
  end

  test do
    sam = testpath/"test.sam"
    sam.write <<~EOS
      @SQ	SN:chr1	LN:500
      r1	0	chr1	100	0	4M	*	0	0	ATGC	ABCD
      r2	0	chr1	200	0	4M	*	0	0	AATT	EFGH
    EOS
    assert_match "SAM", shell_output("#{bin}/htsfile #{sam}")

    system "#{bin}/bgzip -c #{sam} > sam.gz"
    assert_path_exists testpath/"sam.gz"

    system bin/"tabix", "-p", "sam", "sam.gz"
    assert_path_exists testpath/"sam.gz.tbi"
  end
end
