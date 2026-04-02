class ManDb < Formula
  desc "Unix documentation system"
  homepage "https://www.nongnu.org/man-db/"
  url "https://download.savannah.gnu.org/releases/man-db/man-db-2.13.0.tar.xz"
  sha256 "82f0739f4f4a680e3d8ebd668097e14619945040c2c122298fb5ae312dbe4f74"
  license "GPL-2.0-or-later"

  depends_on "pkgconf" => :build
  depends_on "groff"
  depends_on "libpipeline"

  def install
    args = %W[
      --disable-dependency-tracking
      --disable-silent-rules
      --prefix=#{prefix}
      --with-systemdtmpfilesdir=#{etc}/tmpfiles.d
      --with-systemdsystemunitdir=#{etc}/systemd/system
    ]
    system "./configure", *args
    system "make", "install"
  end

  test do
    system bin/"man", "--version"
  end
end
