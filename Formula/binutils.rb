class Binutils < Formula
  desc "GNU binary tools for native development"
  homepage "https://www.gnu.org/software/binutils/binutils.html"
  url "https://ftp.gnu.org/gnu/binutils/binutils-2.46.tar.xz"
  sha256 "6af672b1400d51bca90e710403c2f5c278c67177423b3b0eb72b3f34b32b51dd"
  license "GPL-3.0-or-later"

  keg_only "it shadows the host toolchain"

  depends_on "pkgconf"
  depends_on "zstd"

  def install
    system "./configure", "--prefix=#{prefix}",
                          "--enable-deterministic-archives",
                          "--enable-interwork",
                          "--enable-multilib",
                          "--enable-64-bit-bfd",
                          "--enable-plugins",
                          "--enable-targets=all",
                          "--with-system-zlib",
                          "--with-zstd",
                          "--disable-nls",
                          "--disable-werror"
    system "make"
    system "make", "install"
    
    bin.install_symlink "ld.bfd" => "ld"
  end

  test do
    assert_match "GNU ld", shell_output("#{bin}/ld --version")
  end
end
