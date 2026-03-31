class Gettext < Formula
  desc "GNU internationalization (i18n) and localization (l10n) library"
  homepage "https://www.gnu.org/software/gettext/"
  url "https://ftp.gnu.org/gnu/gettext/gettext-0.22.5.tar.xz"
  mirror "https://ftpmirror.gnu.org/gettext/gettext-0.22.5.tar.xz"
  sha256 "fe10c37353213d78a5b83d48af231e005c4da84db5ce88037d88355938259640"
  license "GPL-3.0-or-later"

  depends_on "acl"
  depends_on "libxml2"
  depends_on "libunistring"
  depends_on "ncurses"
  depends_on "json-c"

  def install
    cpu = Hardware::CPU.loongarch? ? "loongarch64" : Hardware.oldest_cpu

    ENV.prepend_path "PKG_CONFIG_PATH", Formula["json-c"].opt_lib/"pkgconfig"
    ENV.append "CFLAGS", "-I#{Formula["json-c"].opt_include}"
    ENV.append "LDFLAGS", "-L#{Formula["json-c"].opt_lib}"

    args = [
      "--disable-dependency-tracking",
      "--disable-silent-rules",
      "--disable-debug",
      "--prefix=#{prefix}",
      "--with-included-glib",
      "--with-included-libcroco",
      "--with-included-libunistring",
      "--with-libxml2-prefix=#{Formula["libxml2"].opt_prefix}",
      "--without-emacs",
      "--without-git",
      "--build=#{cpu}-unknown-linux-gnu",
      "--disable-java",
      "--disable-csharp"
    ]

    system "./configure", *args
    system "make"
    system "make", "install"
  end

  test do
    system bin/"gettext", "--version"
  end
end
