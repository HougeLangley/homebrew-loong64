class Ncftp < Formula
  desc "FTP client with an advanced user interface"
  homepage "https://www.ncftp.com/"
  url "https://www.ncftp.com/public_ftp/ncftp/ncftp-3.3.0-src.tar.gz"
  mirror "https://fossies.org/linux/misc/ncftp-3.3.0-src.tar.gz"
  sha256 "7920f884c2adafc82c8e41c46d6f3d22698785c7b3f56f5677a8d5c866396386"
  license "ClArtistic"

  livecheck do
    url "https://www.ncftp.com/download/"
    regex(/href=.*?ncftp[._-]v?(\d+(?:\.\d+)+)(?:-src)?\.t/i)
  end


  uses_from_macos "ncurses"

  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "ed5cbd2a2367fd151ba3a7b398a12db0a9243bc60605cbb4cd24947ed2f5394f"
  end

  def install
    # Fix compile with newer Clang
    ENV.append_to_cflags "-Wno-implicit-function-declaration" if DevelopmentTools.clang_build_version >= 1200

    system "./configure", "--disable-universal",
                          "--disable-precomp",
                          "--with-ncurses",
                          "--mandir=#{man}",
                          *std_configure_args
    system "make"
    system "make", "install"
  end

  test do
    system bin/"ncftp", "-F"
  end
end
