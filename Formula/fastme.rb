class Fastme < Formula
  desc "Accurate and fast distance-based phylogeny inference program"
  homepage "http://www.atgc-montpellier.fr/fastme/"
  url "https://gite.lirmm.fr/atgc/FastME/raw/v2.1.6.3/tarball/fastme-2.1.6.3.tar.gz"
  sha256 "09a23ea94e23c0821ab75f426b410ec701dac47da841943587443a25b2b85030"
  license "GPL-3.0-or-later"
  revision 1

  livecheck do
    url "https://gite.lirmm.fr/atgc/FastME.git"
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "658927a4ccdb4b28c1ca1eb5c6af590fe2d6920c94028609c02dd4d464e4ae52"
  end

  on_macos do
    depends_on "libomp"
  end

  deny_network_access!

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "buildaux/#{cf}", "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}", "dist/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    if OS.mac?
      ENV["OPENMP_CFLAGS"] = "-Xpreprocessor -fopenmp"
      ENV["OPENMP_LDFLAG"] = "-lomp"
    end
    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--disable-silent-rules", *std_configure_args
    system "make", "install"
  end

  test do
    (testpath/"test.dist").write <<~EOS
      4
      A 0.0 1.0 2.0 4.0
      B 1.0 0.0 3.0 5.0
      C 2.0 3.0 0.0 6.0
      D 4.0 5.0 6.0 0.0
    EOS

    system bin/"fastme", "-i", "test.dist"
    assert_path_exists testpath/"test.dist_fastme_tree.nwk"
  end
end
