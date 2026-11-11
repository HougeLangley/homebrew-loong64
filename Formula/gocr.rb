class Gocr < Formula
  desc "Optical Character Recognition (OCR), converts images back to text"
  homepage "https://jocr.sourceforge.net/index.html"
  url "https://web.archive.org/web/20250919083502/https://wasd.urz.uni-magdeburg.de/jschulen/ocr/gocr-0.52.tar.gz"
  mirror "https://fossies.org/linux/privat/gocr-0.52.tar.gz"
  sha256 "df906463105f5f4273becc2404570f187d4ea52bd5769d33a7a8661a747b8686"
  license "GPL-2.0-or-later"
  revision 3


  # Upstream homepage is gone
  deprecate! date: "2026-06-22", because: :repo_removed
  disable! date: "2027-06-22", because: :repo_removed


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "95a2162f9a4fdf905cb6c56d0d004a58c37689d5a4f6990882445912ee99107c"
  end

  depends_on "jpeg-turbo"
  depends_on "netpbm"

  # Edit makefile to install libs per developer documentation
  patch do
    file "Patches/gocr/0.50.patch"
  end

  def install
    system "./configure", *std_configure_args

    # --mandir doesn't work correctly; fix broken Makefile
    inreplace "man/Makefile" do |s|
      s.change_make_var! "mandir", "/share/man"
    end

    system "make", "libs"
    system "make", "install"
  end

  test do
    system bin/"gocr", "--help"
  end
end
