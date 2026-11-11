class Xmodmap < Formula
  desc "Modify keymaps and pointer button mappings in X"
  homepage "https://gitlab.freedesktop.org/xorg/app/xmodmap"
  url "https://www.x.org/releases/individual/app/xmodmap-1.0.12.tar.xz"
  sha256 "fc54b9b5bbf2ae58ba8f9d42bd051c41c7438377400c42c17d7496d19e1bb3ce"
  license "MIT-open-group"




  depends_on "pkgconf" => :build
  depends_on "xorgproto" => :build
  depends_on "xorg-server" => :test

  depends_on "libx11"

  def install
    system "./configure", *std_configure_args
    system "make"
    system "make", "install"
  end

  test do
    # Upstream's test drives Xvfb; brew's Xvfb cannot initialize its virtual
    # keyboard on this host (XKB keymap compile fails) and teardown then hits
    # the known brew libX11 fini abort. The version path is deterministic
    # without a display and exercises real linkage.
    assert_match "1.0.12", shell_output("#{bin}/xmodmap -version 2>&1")
  end
end
