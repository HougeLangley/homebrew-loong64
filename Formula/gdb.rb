class Gdb < Formula
  desc "GNU debugger"
  homepage "https://www.gnu.org/software/gdb/"
  url "https://ftp.gnu.org/gnu/gdb/gdb-16.3.tar.gz"
  sha256 "f4b614eb46548018895e34838a077b24430a08fcf30c2c8f70f53386369b57ac"
  license "GPL-3.0-or-later"

  depends_on "pkgconf" => :build
  depends_on "texinfo" => :build
  depends_on "expat"
  depends_on "gmp"
  depends_on "ncurses"
  depends_on "zstd"

  def install
    cpu = Hardware::CPU.loongarch? ? "loongarch64" : Hardware.oldest_cpu
    
    system "./configure", "--prefix=#{prefix}",
                          "--build=#{cpu}-unknown-linux-gnu",
                          "--disable-werror",
                          "--without-guile",
                          "--without-python",
                          "--with-expat",
                          "--with-zstd",
                          "--with-system-zlib",
                          "--disable-nls",
                          "--enable-targets=all",
                          "--enable-64-bit-bfd"
    
    system "make"
    system "make", "install"
    
    # Install library files
    lib.install Dir["lib*/lib*"]
  end

  def caveats
    <<~EOS
      This is a minimal build of GDB without:
      - Guile scripting support (--without-guile)
      - Python scripting support (--without-python)
      
      Core debugging functionality is fully available.
      For full features, build with: --with-python=/path/to/python
    EOS
  end

  test do
    system "#{bin}/gdb", "--version"
  end
end
