class Libgnt < Formula
  desc "NCurses toolkit for creating text-mode graphical user interfaces"
  homepage "https://pidgin.im/"
  url "https://downloads.sourceforge.net/project/pidgin/libgnt/2.14.4/libgnt-2.14.4-dev.tar.xz"
  sha256 "195933a9a731d3575791b881ba5cc0ad2a715e1e9c4c23ccaaa2a17e164c96ec"
  license "GPL-2.0-or-later"
  revision 1

  livecheck do
    url "https://sourceforge.net/projects/pidgin/rss?path=/libgnt"
  end


  bottle do
    rebuild 2
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "397191b205b93b20d813e7ee4e1c8f7ab95d4b4209ff981d4151f0a4e5921ca2"
  end

  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkgconf" => :build

  depends_on "glib"
  depends_on "ncurses"

  uses_from_macos "libxml2"

  on_macos do
    depends_on "gettext"
  end

  def install
    # upstream bug report on this workaround, https://issues.imfreedom.org/issue/LIBGNT-15
    inreplace "meson.build", "ncurses_sys_prefix = '/usr'",
                             "ncurses_sys_prefix = '#{formula_opt_prefix("ncurses")}'"

    system "meson", "setup", "build", "-Ddoc=false", "-Dpython2=false", *std_meson_args
    system "meson", "compile", "-C", "build", "--verbose"
    system "meson", "install", "-C", "build"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <gnt/gnt.h>

      int main() {
          gnt_init();
          gnt_quit();

          return 0;
      }
    C

    flags = [
      "-I#{formula_opt_include("glib")}/glib-2.0",
      "-I#{formula_opt_lib("glib")}/glib-2.0/include",
      "-I#{include}",
      "-L#{lib}",
      "-L#{formula_opt_lib("glib")}",
      "-lgnt",
      "-lglib-2.0",
    ]
    system ENV.cc, "test.c", *flags, "-o", "test"
    system "./test"
  end
end
