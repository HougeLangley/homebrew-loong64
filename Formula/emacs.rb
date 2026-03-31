class Emacs < Formula
  desc "GNU Emacs text editor"
  homepage "https://www.gnu.org/software/emacs/"
  url "https://ftp.gnu.org/gnu/emacs/emacs-30.2.tar.gz"
  sha256 "ba2093df30b01199c27bc12d3126d379de73a8648e1bc1b76b2a3bc861f0b7b1"
  license "GPL-3.0-or-later"

  depends_on "pkgconf" => :build
  depends_on "gmp"
  depends_on "libxml2"
  depends_on "ncurses"
  depends_on "zlib-ng-compat"

  def install
    cpu = Hardware::CPU.loongarch? ? "loongarch64" : Hardware.oldest_cpu
    
    system "./configure", "--prefix=#{prefix}",
                          "--build=#{cpu}-unknown-linux-gnu",
                          "--without-x",
                          "--without-ns",
                          "--without-gnutls",
                          "--without-tree-sitter",
                          "--with-modules",
                          "--disable-silent-rules"
    
    system "make"
    system "make", "install"
    
    # 创建 site-lisp 目录
    (share/"emacs/site-lisp").mkpath
  end

  def caveats
    <<~EOS
      This is a terminal-only build of Emacs without:
      - X11 GUI support (--without-x)
      - macOS Cocoa support (--without-ns)
      - GnuTLS support (--without-gnutls)
      - Tree-sitter support (--without-tree-sitter)
      
      For a full-featured build, you may need to install additional dependencies.
    EOS
  end

  test do
    assert_match "GNU Emacs", shell_output("#{bin}/emacs --version")
  end
end
