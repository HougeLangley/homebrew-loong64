class Htop < Formula
  desc "Improved top (interactive process viewer)"
  homepage "https://htop.dev/"
  url "https://github.com/htop-dev/htop/releases/download/3.4.4/htop-3.4.4.tar.xz"
  sha256 "48eea6c07219f54fbf37d93b3e28e7b99c3a5a3e2c0b1233f8c1c58db8a29130"
  license "GPL-2.0-or-later"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "ncurses"
  depends_on "pkgconf"

  def install
    system "autoreconf", "-vfi"
    
    cpu = Hardware::CPU.loongarch? ? "loongarch64" : Hardware.oldest_cpu
    
    system "./configure", "--prefix=#{prefix}",
                          "--build=#{cpu}-unknown-linux-gnu",
                          "--disable-silent-rules"
    system "make", "install"
  end

  test do
    system "#{bin}/htop", "--version"
  end
end
