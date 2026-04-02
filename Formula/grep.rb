class Grep < Formula
  desc "GNU grep, egrep and fgrep"
  homepage "https://www.gnu.org/software/grep/"
  url "https://ftp.gnu.org/gnu/grep/grep-3.11.tar.xz"
  sha256 "1db2aedade89e0d591081d8d281364fbdb14eb417f19153ede9e74c9432925a6"
  license "GPL-3.0-or-later"

  depends_on "pkgconf" => :build
  depends_on "pcre2"

  def install
    args = %W[
      --prefix=#{prefix}
      --disable-dependency-tracking
      --program-prefix=g
      --without-included-regex
    ]
    system "./configure", *args
    system "make"
    system "make", "install"
    
    bin.install_symlink "ggrep" => "grep"
  end

  test do
    system bin/"ggrep", "--version"
  end
end
