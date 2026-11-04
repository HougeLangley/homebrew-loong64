class Largetifftools < Formula
  desc "Collection of software that can help managing (very) large TIFF files"
  homepage "https://pperso.ijclab.in2p3.fr/page_perso/Deroulers/software/largetifftools/"
  url "https://pperso.ijclab.in2p3.fr/page_perso/Deroulers/software/largetifftools/download/largetifftools-1.4.2/largetifftools-1.4.2.tar.bz2"
  sha256 "a7544d79a93349ebbc755f2b7b6c5fbcd71a01f68d2939dbcba749ba6069fabb"
  license "GPL-3.0-only"

  livecheck do
    url :homepage
    regex(/href=.*?largetifftools[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "61e7e1a49a2ec0df52447f5979edfa582da7ef1d2e741f46f4aacf96188e2433"
  end

  depends_on "jpeg-turbo"
  depends_on "libpng"
  depends_on "libtiff"

  on_macos do
    depends_on "webp"
    depends_on "zstd"
  end

  def install
    system "./configure", "--disable-silent-rules", *std_configure_args
    system "make", "install"
  end

  test do
    system bin/"tifffastcrop", "-p", "-E", "0,0,-1,-1", test_fixtures("test.tiff"), testpath/"output.png"
    assert File.size?(testpath/"output.png")
  end
end
