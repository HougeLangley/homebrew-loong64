class UtilLinux < Formula
  desc "Collection of Linux utilities"
  homepage "https://github.com/util-linux/util-linux"
  url "https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.41/util-linux-2.41.3.tar.xz"
  sha256 "2ad0e6e32400c1b7f5904c6d7c67f5e42c7c79e8555d18d24e22ea46d515f4b4"
  license "BSD-3-Clause"

  depends_on "pkgconf" => :build
  depends_on "libuuid"
  depends_on "ncurses"

  def install
    args = %W[
      --disable-silent-rules
      --prefix=#{prefix}
      --disable-ipcs
      --disable-ipcrm
      --disable-wall
      --disable-write
      --disable-pg
    ]
    system "./configure", *args
    system "make", "install"
  end

  test do
    system bin/"lsblk", "--version"
  end
end
