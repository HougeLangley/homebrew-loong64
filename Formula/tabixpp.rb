class Tabixpp < Formula
  desc "C++ wrapper to tabix indexer"
  homepage "https://github.com/vcflib/tabixpp"
  url "https://github.com/vcflib/tabixpp/archive/refs/tags/v1.1.2.tar.gz"
  sha256 "c850299c3c495221818a85c9205c60185c8ed9468d5ec2ed034470bb852229dc"
  license "MIT"
  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "ea081f0279ceb7caad8105ae4b170ecb9ec1012f664b4d509f2ca4ca230c53af"
  end

  revision 1



  depends_on "htslib"
  depends_on "xz"

  # Backport library rename needed by dependents
  patch do
    url "https://github.com/vcflib/tabixpp/commit/4cebc981b35c67486e7454064c54cddf547fd58a.patch?full_index=1"
    sha256 "d08f2eb62fb7be5457adb4615c7fbda587993899e8d18a9b8ed0647144c8f3f9"
    type :backport
    resolves "https://github.com/vcflib/tabixpp/pull/26"
  end

  def install
    htslib_include = formula_opt_include("htslib")
    args = %W[
      INCLUDES=-I#{htslib_include}
      HTS_HEADERS=#{htslib_include}/htslib/bgzf.h #{htslib_include}/htslib/tbx.h
      HTS_LIB=
      PREFIX=#{prefix}
      DESTDIR=
    ]
    args << "SLIB=libtabixpp.$(SOVERSION).dylib" if OS.mac?

    system "make", "install", *args
    lib.install_symlink shared_library("libtabixpp", version.major.to_s) => shared_library("libtabixpp")
    pkgshare.install "test"
  end

  test do
    cp_r pkgshare/"test", testpath
    system bin/"tabix++", "test/vcf_file.vcf.gz"
    assert_path_exists "test/vcf_file.vcf.gz.tbi"
  end
end
