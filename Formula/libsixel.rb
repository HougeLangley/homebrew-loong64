class Libsixel < Formula
  desc "SIXEL encoder/decoder implementation"
  homepage "https://github.com/saitoha/libsixel"
  url "https://github.com/saitoha/libsixel/releases/download/v1.8.7-r2/sixel-1.8.7-r2.tar.gz"
  version "1.8.7-r2"
  sha256 "9088475e5a1332f84b92ad46fd3c199ac56500c67f8a4054efccbc0db644bdba"
  license "MIT"
  version_scheme 1
  head "https://github.com/saitoha/libsixel.git", branch: "master"

  livecheck do
    url :stable
    regex(/^v(\d+(?:\.\d+)+(:?-r\d+)?)/i)
  end


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "bd429acea5fcff1ab95a3fa2aeee20e1e3848b7f32e579e0128bf8e64bf9c6bd"
  end

  depends_on "pkgconf" => :build
  depends_on "jpeg-turbo"
  depends_on "libpng"

  def install
    system "./configure", "--disable-python",
                          "--without-libcurl",
                          "--with-jpeg",
                          "--with-png",
                          *std_configure_args
    system "make", "install"
  end

  test do
    fixture = test_fixtures("test.png")
    system bin/"img2sixel", fixture
  end
end
