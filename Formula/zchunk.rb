class Zchunk < Formula
  desc "Compressed file format for efficient deltas"
  homepage "https://github.com/zchunk/zchunk"
  url "https://github.com/zchunk/zchunk/archive/refs/tags/1.5.5.tar.gz"
  sha256 "2ab8ef54475aa2b2c0120fc6ae6d0788e0c3d4d4b671985edc6a19c8096a02cc"
  license "BSD-2-Clause"


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
    system "meson", "setup", "build", *std_meson_args
    system "meson", "compile", "-C", "build", "--verbose"
    system "meson", "install", "-C", "build"
  end

  test do
    # Round-trip needs zstd; the tool reports "Unsupported compression type:
    # zstd" if the build failed to link it. Default to the zstd compressor
    # explicitly so a silent loss of zstd support fails loudly here.
    system bin/"zck", "--zstd", "-o", "z.zck", test_fixtures("test.png")
    system bin/"unzck", "z.zck", "-o", "out.png"
    assert_equal test_fixtures("test.png").read, (testpath/"out.png").read
  end
end
