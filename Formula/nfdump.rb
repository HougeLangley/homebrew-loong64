class Nfdump < Formula
  desc "Tools to collect and process netflow data on the command-line"
  homepage "https://github.com/phaag/nfdump"
  url "https://github.com/phaag/nfdump/archive/refs/tags/v1.7.10.tar.gz"
  sha256 "9a1bc84eb484c7383eea3b48ad2abe5b9ffe7e90aab3fda7055aa3f64be0cc29"
  license "BSD-3-Clause"
  head "https://github.com/phaag/nfdump.git", branch: "master"


  bottle do
    rebuild 2
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "1d9aad3df1f74cd383061c7f7b9e15e82fbc036e990fb8304be0d95a722c3b7d"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkgconf" => :build

  uses_from_macos "bison" => :build
  uses_from_macos "flex" => :build
  uses_from_macos "bzip2"
  uses_from_macos "libpcap"

  on_linux do
    depends_on "libbsd"
  end

  def install
    # FIXME: the macOS 27 SDK `fts.h` includes `<fts_compat.h>`, which resolves to the bundled
    # `src/libnffile/fts_compat.h` instead, so build the bundled fts implementation there
    ENV["ac_cv_header_fts_h"] = "no" if OS.mac? && MacOS.version >= :golden_gate

    system "./autogen.sh"
    system "./configure", "--enable-readpcap", "LEXLIB=", *std_configure_args
    system "make", "install"
  end

  test do
    system bin/"nfdump", "-Z", "host 8.8.8.8"
  end
end
