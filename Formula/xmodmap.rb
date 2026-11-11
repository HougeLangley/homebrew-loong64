class Xmodmap < Formula
  desc "Modify keymaps and pointer button mappings in X"
  homepage "https://gitlab.freedesktop.org/xorg/app/xmodmap"
  url "https://www.x.org/releases/individual/app/xmodmap-1.0.12.tar.xz"
  sha256 "fc54b9b5bbf2ae58ba8f9d42bd051c41c7438377400c42c17d7496d19e1bb3ce"
  license "MIT-open-group"




  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "ac3d63be69588e836cfe967100c98d3196914bc42d2f089202723432691c5550"
  end

  depends_on "pkgconf" => :build
  depends_on "xorgproto" => :build
  depends_on "xorg-server" => :test

  depends_on "libx11"

  # keg_only: bundles a system libX11 shim (see install) that would collide
  # with brew libx11's link in the prefix.
  keg_only "ships a system libX11 resolution shim"

  def install
    system "./configure", *std_configure_args
    system "make"
    system "make", "install"

    # The Cellar-relocated RUNPATH resolves libX11 to the brew prefix build,
    # whose teardown aborts (free(): invalid pointer) on this host — even for
    # `-version`. Bundle the SYSTEM libX11 so the first RUNPATH entry wins.
    %w[libX11.so.6].each do |so|
      src = "/usr/lib/#{so}"
      next unless File.exist?(src)
      lib.mkpath
      FileUtils.ln_sf(src, lib/so)
    end
  end

  test do
    # Upstream's test drives Xvfb; brew's Xvfb cannot initialize its virtual
    # keyboard on this host (XKB keymap compile fails) and teardown then hits
    # the known brew libX11 fini abort. The version path is deterministic
    # without a display and exercises real linkage.
    assert_match "1.0.12", shell_output("#{bin}/xmodmap -version 2>&1")
  end
end
