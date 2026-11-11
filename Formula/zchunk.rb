class Zchunk < Formula
  desc "Compressed file format for efficient deltas"
  homepage "https://github.com/zchunk/zchunk"
  url "https://github.com/zchunk/zchunk/archive/refs/tags/1.5.5.tar.gz"
  sha256 "2ab8ef54475aa2b2c0120fc6ae6d0788e0c3d4d4b671985edc6a19c8096a02cc"
  license "BSD-2-Clause"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "c5bd38a19bd12dd6c3fc96a7b99f16486710be2d86e8a5950d559a2971169d54"
  end

  head "https://github.com/zchunk/zchunk.git", branch: "main"



  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkgconf" => :build
  depends_on "openssl@4"
  depends_on "zstd"

  uses_from_macos "curl"

  on_macos do
    depends_on "argp-standalone" => :build
  end

  deny_network_access!

  def install
    # Force zstd support: superenv's isolated pkg-config search sometimes
    # misses the brew zstd .pc, silently building without the default
    # compressor.
    system "meson", "setup", "build", *std_meson_args, "-Dwith-zstd=enabled"
    system "meson", "compile", "-C", "build", "--verbose"
    system "meson", "install", "-C", "build"
  end

  test do
    # zchunk's default compressor is zstd; the original failure ("Unsupported
    # compression type: zstd") means the build lost zstd support.
    system bin/"zck", test_fixtures("test.png")
    system bin/"unzck", testpath/"test.png.zck"
    assert_equal test_fixtures("test.png").read, (testpath/"test.png").read
  end
end
