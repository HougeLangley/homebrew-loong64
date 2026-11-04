class DesktopFileUtils < Formula
  desc "Command-line utilities for working with desktop entries"
  homepage "https://wiki.freedesktop.org/www/Software/desktop-file-utils/"
  url "https://www.freedesktop.org/software/desktop-file-utils/releases/desktop-file-utils-0.28.tar.xz"
  sha256 "4401d4e231d842c2de8242395a74a395ca468cd96f5f610d822df33594898a70"
  license "GPL-2.0-or-later"


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "3bbd15b5d81a1072d44972b5541811c2e78a4e01eddcf4956961009ac8c3fd8c"
  end

  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkgconf" => :build

  depends_on "glib"

  on_macos do
    depends_on "gettext"
  end

  def install
    system "meson", "setup", "build", *std_meson_args
    system "meson", "compile", "-C", "build", "--verbose"
    system "meson", "install", "-C", "build"

    # fix lisp file install location
    mkdir_p share/"emacs/site-lisp/desktop-file-utils"
    mv share/"emacs/site-lisp/desktop-entry-mode.el", share/"emacs/site-lisp/desktop-file-utils"
  end

  test do
    (testpath/"test.desktop").write <<~DESKTOP
      [Desktop Entry]
      Version=1.0
      Type=Application
      Name=Foo Viewer
      Comment=The best viewer for Foo objects available!
      TryExec=fooview
      Exec=fooview %F
      Icon=fooview
      MimeType=image/x-foo;
      Actions=Gallery;Create;

      [Desktop Action Gallery]
      Exec=fooview --gallery
      Name=Browse Gallery

      [Desktop Action Create]
      Exec=fooview --create-new
      Name=Create a new Foo!
      Icon=fooview-new
    DESKTOP

    system bin/"desktop-file-validate", "test.desktop"
  end
end
