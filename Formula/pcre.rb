class Pcre < Formula
  desc "Perl compatible regular expressions library"
  homepage "https://www.pcre.org/"
  url "https://downloads.sourceforge.net/project/pcre/pcre/8.45/pcre-8.45.tar.bz2"
  mirror "https://www.mirrorservice.org/sites/ftp.exim.org/pub/pcre/pcre-8.45.tar.bz2"
  sha256 "4dae6fdcd2bb0bb6c37b5f97c33c2be954da743985369cddac3546e3218bffb8"
  license "BSD-3-Clause"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "3317f8835419ff0877f1430d0cab779ea7d8fb1b83f34482ddfc5ad15dcdb423"
  end

  # From the PCRE homepage:
  # "The older, but still widely deployed PCRE library, originally released in
  # 1997, is at version 8.45. This version of PCRE is now at end of life, and
  # is no longer being actively maintained. Version 8.45 is expected to be the
  # final release of the older PCRE library, and new projects should use PCRE2
  # instead."
  livecheck do
    skip "PCRE was declared end of life in 2021-06"
  end


  # Final release on 2021-06-22. As an exception, PCRE is given an extended
  # deprecation period with removal set for 10 years after last release.
  #
  # PCRE was also removed in major Linux distros like Debian 13, RHEL 10,
  # Ubuntu 26.04 and Fedora 45.
  #
  # The dates set should allow most maintained projects to migrate as it
  # happens after:
  # * Debian 12 LTS ends on 2028-06-30 removing PCRE from all maintained Debian
  # * Ubuntu 24.04 security support ends on 2029-05-31 which will lead to
  #   removal from CI runners like GitHub Actions
  disable! date: "2030-06-22", because: :unmaintained, replacement_formula: "pcre2"

  uses_from_macos "bzip2"

  on_linux do
    depends_on "zlib-ng-compat"
  end

  # Fix -flat_namespace being used on Big Sur and later.
  patch do
    file "Patches/libtool/configure-big_sur.diff"
    type :unofficial
  end

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    args = %w[
      --enable-utf8
      --enable-pcre8
      --enable-pcre16
      --enable-pcre32
      --enable-unicode-properties
      --enable-pcregrep-libz
      --enable-pcregrep-libbz2
    ]

    # JIT not currently supported for Apple Silicon
    args << "--enable-jit" if OS.mac? && !Hardware::CPU.arm?

    system "./configure", "--build=loongarch64-unknown-linux-gnu", *args, *std_configure_args
    system "make"
    ENV.deparallelize
    system "make", "test"
    system "make", "install"
  end

  test do
    system bin/"pcregrep", "regular expression", prefix/"README"
  end
end
