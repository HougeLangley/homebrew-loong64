class Xz < Formula
  desc "General-purpose data compression with high compression ratio"
  homepage "https://tukaani.org/xz/"
  url "https://downloads.sourceforge.net/project/lzmautils/xz-5.6.3.tar.xz"
  sha256 "db0590629b6f0fa26ab49df018ad86f38a7b947c58d3197bd0e6eb2b4f5e1f49"
  license "BSD-2-Clause"

  def install
    system "./configure", "--disable-silent-rules", "--prefix=#{prefix}"
    system "make", "check"
    system "make", "install"
  end

  test do
    system bin/"xz", "--version"
  end
end
