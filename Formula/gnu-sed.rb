class GnuSed < Formula
  desc "GNU implementation of the famous stream editor"
  homepage "https://www.gnu.org/software/sed/"
  url "https://ftp.gnu.org/gnu/sed/sed-4.9.tar.xz"
  sha256 "6e226b732e1cd739464ad8c3bf28b5e7485db87a28d657f81ae071e461a38a5b"
  license "GPL-3.0-or-later"

  def install
    args = %W[
      --prefix=#{prefix}
      --disable-dependency-tracking
      --program-prefix=g
    ]
    system "./configure", *args
    system "make", "install"
    
    bin.install_symlink "gsed" => "sed"
  end

  test do
    system bin/"gsed", "--version"
  end
end
