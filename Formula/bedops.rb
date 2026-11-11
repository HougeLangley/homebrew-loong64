class Bedops < Formula
  desc "Set and statistical operations on genomic data of arbitrary scale"
  homepage "https://github.com/bedops/bedops"
  url "https://github.com/bedops/bedops/archive/refs/tags/v2.4.42.tar.gz"
  sha256 "9daa0c098e37490a07f84664d2c61ff8909689995cf7e1673d259ccd4f1c453c"
  license "GPL-2.0-or-later"



  bottle do
    rebuild 2
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "0be7d4b8715475362c3e9893f720eb3c86bc6e26ac44e173bc4f24b3c95dd62d"
  end

  depends_on "jansson"

  uses_from_macos "bzip2"

  on_linux do
    depends_on "zlib-ng-compat"
  end

  # Apply Debian patch to allow using system/brew libraries
  patch do
    file "Patches/bedops/2.4.42-debian.patch"
    type :unofficial
  end

  def install
    rm_r "third-party"

    # Avoid running `support` target which builds third-party libraries.
    # On Linux, this is already handled by the Debian patch.
    inreplace "system.mk/Makefile.darwin", /^default: support$/, "default: mkdirs"

    args = %W[
      BUILD_ARCH=#{Hardware::CPU.arch}
      JPARALLEL=#{ENV.make_jobs}
      LOCALBZIP2LIB=-lbz2
      LOCALJANSSONLIB=-ljansson
      LOCALZLIBLIB=-lz
    ]
    args << "MIN_OSX_VERSION=#{MacOS.version}" if OS.mac?

    system "make", *args
    system "make", "install", "BINDIR=#{bin}"
  end

  test do
    (testpath/"first.bed").write <<~EOS
      chr1\t100\t200
    EOS
    (testpath/"second.bed").write <<~EOS
      chr1\t300\t400
    EOS
    output = shell_output("#{bin}/bedops --complement first.bed second.bed")
    assert_match "chr1\t200\t300", output
  end
end
