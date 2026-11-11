class Xcursorgen < Formula
  desc "Create an X cursor file from a collection of PNG images"
  homepage "https://gitlab.freedesktop.org/xorg/app/xcursorgen"
  url "https://gitlab.freedesktop.org/xorg/app/xcursorgen/-/archive/xcursorgen-1.0.9/xcursorgen-xcursorgen-1.0.9.tar.bz2"
  sha256 "a350f67323786aceef063e471d1661ae7e6d6ecb44e9143cf409070ad9ed053b"
  license "MIT"

  livecheck do
    url :stable
    regex(/^xcursorgen[._-]v?(\d+(?:\.\d+)+)$/i)
  end

  # keg_only: we bundle system X library shims in lib/ (see install) that
  # would collide with brew libx11/libxcursor links in the prefix.
  keg_only "ships system X11 resolution shims"




  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "64b586b66860b25c96bbc111e79dd5b7df98fd749070fcc86502807a522470a0"
  end

  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkgconf" => :build
  depends_on "libpng"
  depends_on "libx11"
  depends_on "libxcursor"

  def install
    system "meson", "setup", "build", *std_meson_args
    system "meson", "compile", "-C", "build", "--verbose"
    system "meson", "install", "-C", "build"

    # brew's prefix-level libX11 chain aborts at process teardown on this
    # host (minimal XOpenDisplay probe reproduces free(): invalid pointer;
    # same root cause as xsel). Bundle SYSTEM X library symlinks in the keg
    # so the first RUNPATH entry ($ORIGIN/../lib) always resolves to the
    # working system stack; absolute system paths keep the bottle portable.
    %w[libX11.so.6 libXcursor.so.1].each do |so|
      src = "/usr/lib/#{so}"
      next unless File.exist?(src)
      lib.mkpath
      FileUtils.ln_sf(src, lib/so)
    end
  end

  test do
    (testpath/"test.cursor").write "8 2 4 test.png"
    testpath.install_symlink test_fixtures("test.png")
    system bin/"xcursorgen", "test.cursor", "test"
    bytes = (testpath/"test").binread(4).unpack("C*")
    assert_equal [0x58, 0x63, 0x75, 0x72], bytes
  end
end
