class Rsync < Formula
  desc "Utility that provides fast incremental file transfer"
  homepage "https://rsync.samba.org/"
  url "https://rsync.samba.org/ftp/rsync/rsync-3.3.0.tar.gz"
  sha256 "7399e9a6708c0d2c2932589ffd4b0a7a2e6eba78f9b7a47a12b172c94c4b6a0d"
  license "GPL-3.0-or-later"

  depends_on "lz4"
  depends_on "openssl@3"
  depends_on "popt"
  depends_on "xxhash"
  depends_on "zstd"

  uses_from_macos "zlib"

  def install
    args = %W[
      --prefix=#{prefix}
      --disable-debug
      --with-rsyncd-conf=#{etc}/rsyncd.conf
      --with-included-popt=no
      --with-included-zlib=no
      --enable-openssl
      --with-openssl=#{Formula["openssl@3"].opt_prefix}
    ]
    
    system "./configure", *args
    system "make"
    system "make", "install"
  end

  test do
    system bin/"rsync", "--version"
  end
end
