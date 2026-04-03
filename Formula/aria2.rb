class Aria2 < Formula
  desc "Download with resuming and segmented downloading"
  homepage "https://aria2.github.io/"
  url "https://github.com/aria2/aria2/releases/download/release-1.37.0/aria2-1.37.0.tar.xz"
  sha256 "60a420ad7085eb616cb6e2bdf0a7206d68ff3d37fb5a956dc44242eb2f79b66b"
  license "GPL-2.0-or-later"

  depends_on "pkgconf" => :build
  depends_on "gettext"
  depends_on "libssh2"
  depends_on "sqlite"
  depends_on "openssl@3"
  depends_on "xxhash"
  depends_on "zlib-ng-compat"

  uses_from_macos "libxml2"
  uses_from_macos "zlib"

  def install
    ENV.cxx11
    
    args = %W[
      --disable-dependency-tracking
      --prefix=#{prefix}
      --with-libssh2
      --without-tcmalloc
      --without-libcares
    ]
    
    system "./configure", *args
    system "make", "install"
  end

  test do
    system bin/"aria2c", "--version"
  end
end
