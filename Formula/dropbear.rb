class Dropbear < Formula
  desc "Small SSH server/client for POSIX-based system"
  homepage "https://matt.ucc.asn.au/dropbear/dropbear.html"
  url "https://matt.ucc.asn.au/dropbear/releases/dropbear-2026.94.tar.bz2"
  sha256 "e098034a843699200c8c977a991fff73159735bf795d5f72ef672c41a6b1ae81"
  license "MIT"

  livecheck do
    url :homepage
    regex(/href=.*?dropbear[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  head do
    url "https://github.com/mkj/dropbear.git", branch: "main"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
  end

  uses_from_macos "libxcrypt"

  on_linux do
    depends_on "linux-pam"
    depends_on "zlib-ng-compat"
  end

  deny_network_access!

  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "6c5a309bcb4d90d6ab593dc0d1cadccc92e35ac85b2da950f3b87650edcfefce"
  end

  def install
    ENV.deparallelize

    # It doesn't compile on macOS with these macros because of the missing `setresgid()` function
    # There's no option to disable it via `./configure` flags and upstream suggests to fix it
    # by changing `src/default_options.h` manually (see `CHANGES`)
    if OS.mac?
      inreplace "src/default_options.h" do |s|
        s.gsub! "#define DROPBEAR_SVR_DROP_PRIVS DROPBEAR_SVR_MULTIUSER",
                "#define DROPBEAR_SVR_DROP_PRIVS 0"
        s.gsub! "#define DROPBEAR_SVR_LOCALSTREAMFWD 1",
                "#define DROPBEAR_SVR_LOCALSTREAMFWD 0"
      end
    end

    if build.head?
      system "autoconf"
      system "autoheader"
    end
    system "./configure", "--prefix=#{prefix}",
                          "--enable-pam",
                          "--enable-zlib",
                          "--enable-bundled-libtom",
                          "--sysconfdir=#{etc}/dropbear"
    system "make"
    system "make", "install"
  end

  test do
    testfile = testpath/"testec521"
    system bin/"dbclient", "-h"
    system bin/"dropbearkey", "-t", "ecdsa", "-f", testfile, "-s", "521"
    assert_path_exists testfile
  end
end
