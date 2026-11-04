class Libtar < Formula
  desc "C library for manipulating POSIX tar files"
  homepage "https://repo.or.cz/libtar.git"
  url "https://repo.or.cz/libtar.git",
      tag:      "v1.2.20",
      revision: "0907a9034eaf2a57e8e4a9439f793f3f05d446cd"
  license "NCSA"


  bottle do
    rebuild 5
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "79b4c730c9fbda779cedbda73ed19228b66d19e854af4e30387610a7ae5ffe84"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  on_linux do
    depends_on "zlib-ng-compat"
  end

  def install
    # K&R function definitions in `compat/` are invalid in the C23 default that autoconf 2.73 picks
    ENV["ac_cv_prog_cc_c23"] = "no"
    system "autoreconf", "--force", "--install", "--verbose"
    system "./configure", "--mandir=#{man}", *std_configure_args
    system "make", "install"
  end

  test do
    (testpath/"homebrew.txt").write "This is a simple example"
    # bsdtar's default pax format adds extended headers for macOS xattrs, which libtar cannot read
    system "tar", "--format=ustar", "-cvf", "test.tar", "homebrew.txt"
    rm "homebrew.txt"
    refute_path_exists testpath/"homebrew.txt"
    assert_path_exists testpath/"test.tar"

    system bin/"libtar", "-x", "test.tar"
    assert_path_exists testpath/"homebrew.txt"
  end
end
