class Autogen < Formula
  desc "Automated text file generator"
  homepage "https://autogen.sourceforge.net/"
  url "https://ftpmirror.gnu.org/autogen/rel5.18.16/autogen-5.18.16.tar.xz"
  mirror "https://ftp.gnu.org/gnu/autogen/rel5.18.16/autogen-5.18.16.tar.xz"
  sha256 "f8a13466b48faa3ba99fe17a069e71c9ab006d9b1cfabe699f8c60a47d5bb49a"
  license "GPL-3.0-or-later"
  revision 3

  livecheck do
    url :stable
    regex(%r{href=.*?rel(\d+(?:\.\d+)+)/?["' >]}i)
  end


  depends_on "coreutils" => :build
  depends_on "pkgconf" => :build

  depends_on "guile"

  uses_from_macos "libxml2"

  on_macos do
    depends_on "bdw-gc"
  end

  # Fix -flat_namespace being used on Big Sur and later.
  patch do
    file "Patches/libtool/configure-big_sur.diff"
    type :unofficial
  end

  # Fix guile detection
  patch do
    file "Patches/autogen/5.18.16.patch"
    type :unofficial
    resolves "https://sourceforge.net/p/autogen/bugs/196/"
  end

  deny_network_access!

  def install
    # Uses GNU-specific mktemp syntax: https://sourceforge.net/p/autogen/bugs/189/
    inreplace %w[agen5/mk-stamps.sh build-aux/run-ag.sh config/mk-shdefs.in], "mktemp", "gmktemp"
    # Upstream bug regarding "stat" struct: https://sourceforge.net/p/autogen/bugs/187/
    system "./configure", "ac_cv_func_utimensat=no",
                          "--disable-silent-rules",
                          *std_configure_args

    # make and install must be separate steps for this formula
    system "make"
    system "make", "install"
  end

  test do
    system bin/"autogen", "-v"
  end
end
