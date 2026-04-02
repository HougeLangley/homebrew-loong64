class GnuTar < Formula
  desc "GNU version of the tar archiving utility"
  homepage "https://www.gnu.org/software/tar/"
  url "https://ftp.gnu.org/gnu/tar/tar-1.35.tar.xz"
  sha256 "4d62ff37342ec7aed748535323930c7cf94acf71c3591882b26a7ea50f3edc16"
  license "GPL-3.0-or-later"

  def install
    args = %W[
      --prefix=#{prefix}
      --disable-dependency-tracking
      --program-prefix=g
    ]
    system "./configure", *args
    system "make", "install"
    
    bin.install_symlink "gtar" => "tar"
  end

  test do
    system bin/"gtar", "--version"
  end
end
