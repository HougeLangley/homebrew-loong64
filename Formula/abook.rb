class Abook < Formula
  desc "Address book with mutt support"
  homepage "https://abook.sourceforge.io/"
  license all_of: [
    "GPL-3.0-only",
    "GPL-2.0-or-later",  # mbswidth.c
    "LGPL-2.0-or-later", # getopt.c
    "BSD-2-Clause",      # xmalloc.c
    "BSD-4.3RENO",       # ldif.c
  ]
  head "https://git.code.sf.net/p/abook/git.git", branch: "master"

  stable do
    url "https://abook.sourceforge.io/devel/abook-0.6.2.tar.gz"
    sha256 "2d6bde2d2d03523f164f930e4fdec6025f3a94abe48a43706f543880a1a21ebe"

    # Backport of https://sourceforge.net/p/abook/git/ci/39484721c44629fb1f54d92f09c92ef4c3201302/
    patch do
      file "Patches/abook/39484721c44629fb1f54d92f09c92ef4c3201302.patch"
      type :backport
    end
  end

  livecheck do
    url :homepage
    regex(/href=.*?abook[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "bd10eeaa231a58bd41a1bea24de9e5b35bfcba41a4d51b6760461b2224953615"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "gettext" => :build
  depends_on "readline"

  uses_from_macos "ncurses"

  on_macos do
    depends_on "gettext"
  end

  deny_network_access!

  def install
    ENV.append "CFLAGS", "-std=gnu17" if DevelopmentTools.clang_build_version >= 1700
    system "autoreconf", "--force", "--install", "--verbose"
    system "./configure", "--disable-silent-rules", *std_configure_args
    system "make", "install"
  end

  test do
    system bin/"abook", "--formats"
  end
end
