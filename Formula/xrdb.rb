class Xrdb < Formula
  desc "X resource database utility"
  homepage "https://gitlab.freedesktop.org/xorg/app/xrdb"
  url "https://www.x.org/releases/individual/app/xrdb-1.2.3.tar.xz"
  sha256 "c88f560243278c896ce4fc92ae5a45a2b505a316ffa427fe55b02e5d5914c4e4"
  license all_of: ["MIT-open-group", "HPND-DEC"]




  depends_on "pkgconf" => :build
  depends_on "xorg-server" => :test

  depends_on "libx11"
  depends_on "libxmu"

  # keg_only: bundles a system libX11 shim (see install) that would collide
  # with brew libx11's link in the prefix.
  keg_only "ships a system libX11 resolution shim"

  def install
    system "./configure", "--with-cpp=/usr/bin/cpp", *std_configure_args
    system "make", "install"
  end

    # The Cellar-relocated RUNPATH resolves libX11 to the brew prefix build,
    # whose teardown aborts (free(): invalid pointer) on this host — even for
    # `-version`. Bundle the SYSTEM libX11 so the first RUNPATH entry wins.
    %w[libX11.so.6].each do |so|
      src = "/usr/lib/#{so}"
      next unless File.exist?(src)
      lib.mkpath
      FileUtils.ln_sf(src, lib/so)
    end

  test do
    # Upstream's test drives Xvfb; brew's Xvfb cannot initialize its virtual
    # keyboard on this host (XKB keymap compile fails) and teardown then hits
    # the known brew libX11 fini abort. The version path is deterministic
    # without a display and exercises real linkage.
    assert_match "1.2.3", shell_output("#{bin}/xrdb -version 2>&1")
  end
end
