class Xsel < Formula
  desc "Command-line program for getting and setting the contents of the X selection"
  homepage "https://www.vergenet.net/~conrad/software/xsel/"
  url "https://github.com/kfish/xsel/archive/refs/tags/1.2.1.tar.gz"
  sha256 "18487761f5ca626a036d65ef2db8ad9923bf61685e06e7533676c56d7d60eb14"
  license "HPND-sell-variant"
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "571e0af2470f387f514c938cfdd2a7e2c1ad90f79458f1e459c54f611ea170e4"
  end

  head "https://github.com/kfish/xsel.git", branch: "master"


  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkgconf" => :build

  # keg_only: we bundle a system libX11 symlink in lib/ (see install) which
  # would collide with the brew libx11 link in the prefix.
  keg_only "ships a system libX11 resolution shim"

  # Link the system X11 stack instead of brew's: loading brew libX11 (with
  # its prefix-level xcb chain) into a process aborts with "free(): invalid
  # pointer" at library teardown on this host — reproduced with a minimal
  # XOpenDisplay probe under LD_LIBRARY_PATH, while the same probe against
  # system X11 exits 0 (same family as the libcec randr finding). AOSC
  # desktops always ship libX11, so link it from /usr.

  def install
    # Resolve X11 from the system (see dependency note): AOSC's system
    # x11.pc still Requires legacy xproto/kbproto pc files that are not
    # shipped, so bypass pkg-config entirely. xsel's configure uses
    # PKG_CHECK_MODULES([X], [x11]) — cache its X_CFLAGS/X_LIBS variables.
    ENV["X_CFLAGS"] = "-I/usr/include"
    ENV["X_LIBS"] = "-L/usr/lib -lX11"
    system "./autogen.sh", *std_configure_args
    system "make", "install"

    # Even a system-X11-linked xsel crashes in the Cellar: the relocated
    # RUNPATH's second entry ($ORIGIN/../../../../lib) resolves to the brew
    # prefix lib, whose brew libX11 chain aborts at process teardown on this
    # host. Place the SYSTEM libX11 inside our keg so the first RUNPATH
    # entry always wins. Absolute system path keeps the bottle portable.
    lib.mkpath
    FileUtils.ln_sf("/usr/lib/libX11.so.6", lib/"libX11.so.6")
  end

  test do
    assert_match "Usage: xsel [options]", shell_output("#{bin}/xsel --help")
    assert_match "xsel version #{version} ", shell_output("#{bin}/xsel --version")
    assert_match "xsel: Can't open display", shell_output("DISPLAY= #{bin}/xsel -o 2>&1", 1)
  end
end
