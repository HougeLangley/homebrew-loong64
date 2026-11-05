class Torsocks < Formula
  desc "Use SOCKS-friendly applications with Tor"
  homepage "https://gitlab.torproject.org/tpo/core/torsocks"
  url "https://gitlab.torproject.org/tpo/core/torsocks/-/archive/v2.5.0/torsocks-v2.5.0.tar.bz2"
  sha256 "31a917328b221e955230b7663abfbc50d3a9b445a68cb0313c11cf884f8cb41f"
  license "GPL-2.0-only"
  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "1278aa57ff00a28513db24eeff164e31be365937102ed1129362a6d887bdfdab"
  end

  head "https://gitlab.torproject.org/tpo/core/torsocks.git", branch: "main"



  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  # Guard Linux-only accept4 so it builds on macOS
  patch do
    url "https://gitlab.torproject.org/legacy/trac/uploads/9efc1c0c47b3950aa91e886b01f7e87d/0001-Fix-macros-for-accept4-2.patch"
    sha256 "97881f0b59b3512acc4acb58a0d6dfc840d7633ead2f400fad70dda9b2ba30b0"
    type :unofficial
    resolves "https://gitlab.torproject.org/legacy/trac/-/issues/28538"
  end

  def install
    # Fix compile with newer Clang
    ENV.append_to_cflags "-Wno-implicit-function-declaration" if DevelopmentTools.clang_build_version >= 1403
    # C23 rejects the implicit `gethostbyaddr_r` declaration in `tests/test_dns.c` outright
    ENV["ac_cv_prog_cc_c23"] = "no"

    system "./autogen.sh"
    system "./configure", "--disable-silent-rules", *std_configure_args
    system "make", "install"
  end

  test do
    system bin/"torsocks", "--help"
  end
end
