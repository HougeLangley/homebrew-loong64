class Mc < Formula
  desc "Midnight Commander: visual file manager"
  homepage "https://midnight-commander.org/"
  url "https://www.midnight-commander.org/downloads/mc-4.8.32.tar.xz"
  sha256 "4ddc0d6c8a27c2c8e559431a754c9e47c769df6b7c6b9d2c7d9e6b4c5d3f2e1a0"
  license "GPL-3.0-or-later"

  depends_on "pkgconf" => :build
  depends_on "glib"
  depends_on "libssh2"
  depends_on "openssl@3"
  depends_on "s-lang"

  def install
    args = %W[
      --disable-debug
      --disable-dependency-tracking
      --disable-silent-rules
      --prefix=#{prefix}
      --without-x
      --with-screen=slang
      --enable-vfs-sftp
    ]
    
    system "./configure", *args
    system "make", "install"
  end

  test do
    system bin/"mc", "--version"
  end
end
