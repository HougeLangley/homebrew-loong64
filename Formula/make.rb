class Make < Formula
  desc "Utility for directing compilation"
  homepage "https://www.gnu.org/software/make/"
  url "https://ftp.gnu.org/gnu/make/make-4.4.1.tar.lz"
  sha256 "8814ba0725d133c3eb69155540b89d43b3fb344af1bf3eb9808c2f8b9a5b0e5c"
  license "GPL-3.0-or-later"

  def install
    args = %W[
      --prefix=#{prefix}
      --disable-dependency-tracking
      --program-prefix=g
    ]
    system "./configure", *args
    system "make", "install"
  end

  test do
    system bin/"gmake", "--version"
  end
end
