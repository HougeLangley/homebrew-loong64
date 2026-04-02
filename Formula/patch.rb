class Patch < Formula
  desc "Apply a diff file to an original"
  homepage "https://savannah.gnu.org/projects/patch/"
  url "https://ftp.gnu.org/gnu/patch/patch-2.7.6.tar.xz"
  sha256 "ac610bda97abe0d9f6b7c963235a31aca47ee65883e07757c1edfe2e4931c51c"
  license "GPL-3.0-or-later"

  def install
    system "./configure", "--disable-dependency-tracking", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system bin/"patch", "--version"
  end
end
