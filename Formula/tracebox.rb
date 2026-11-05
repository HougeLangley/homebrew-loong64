class Tracebox < Formula
  desc "Middlebox detection tool"
  homepage "https://github.com/tracebox/tracebox"
  url "https://github.com/tracebox/tracebox.git",
      tag:      "v0.4.4",
      revision: "4fc12b2e330e52d340ecd64b3a33dbc34c160390"
  license all_of: [
  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "d7c9d6a70e5884ef4d5d26503ea0016913f0a34f0f2615ee87aa9941b1748bb0"
  end

    "GPL-2.0-only",
    "BSD-3-Clause", # noinst/libcrafter
  ]
  revision 4
  head "https://github.com/tracebox/tracebox.git", branch: "master"



  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "json-c"
  depends_on "lua"

  uses_from_macos "libpcap"

  def install
    unless OS.mac?
      ENV.cxx11 # work around error: reference to 'byte' is ambiguous
      ENV.append_to_cflags "-I#{formula_opt_include("libpcap")}"
      ENV.append "LDFLAGS", "-L#{formula_opt_lib("libpcap")}"
    end
    # Work around limited `libpcap` and `lua` search paths in configure.ac
    ENV.append "LIBS", "-lpcap -lm"
    ENV["LUA_INCLUDE"] = "-I#{formula_opt_include("lua")}/lua"
    ENV["LUA_LIB"] = "-L#{formula_opt_lib("lua")} -llua"

    system "autoreconf", "--force", "--install", "--verbose"
    system "./configure", "--disable-silent-rules",
                          "--with-libpcap=yes",
                          *std_configure_args
    system "make"
    system "make", "install"
  end

  def caveats
    <<~EOS
      Tracebox requires superuser privileges e.g. run with sudo.

      You should be certain that you trust any software you are executing with
      elevated privileges.
    EOS
  end

  test do
    system bin/"tracebox", "-v"
  end
end
