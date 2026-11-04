class DbusGlib < Formula
  desc "GLib bindings for the D-Bus message bus system"
  homepage "https://wiki.freedesktop.org/www/Software/DBusBindings/"
  url "https://dbus.freedesktop.org/releases/dbus-glib/dbus-glib-0.116.tar.gz"
  sha256 "e3f3d4487e2883800770ed5899ed111bdc4ba7056af34a255c4c46ad8a2486f3"
  license all_of: [
    "GPL-2.0-or-later", # dbus/dbus-bash-completion-helper.c
    any_of: ["AFL-2.1", "GPL-2.0-or-later"],
  ]

  livecheck do
    url "https://dbus.freedesktop.org/releases/dbus-glib/"
    regex(/href=.*?dbus-glib[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "a720e079aef299426b510081725295e2352fd96f99e6d456220803089bf236fe"
  end

  depends_on "pkgconf" => :build
  depends_on "dbus"
  depends_on "glib"

  uses_from_macos "expat"

  on_macos do
    depends_on "gettext"
  end

  deny_network_access!

  def install
    system "./configure", "--disable-silent-rules", *std_configure_args
    system "make", "install"
  end

  test do
    system bin/"dbus-binding-tool", "--help"
  end
end
