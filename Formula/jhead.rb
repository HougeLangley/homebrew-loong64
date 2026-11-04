class Jhead < Formula
  desc "Extract Digicam setting info from EXIF JPEG headers"
  homepage "https://github.com/Matthias-Wandel/jhead"
  url "https://github.com/Matthias-Wandel/jhead/archive/refs/tags/3.08.tar.gz"
  sha256 "999a81b489c7b2a7264118f194359ecf4c1b714996a2790ff6d5d2f3940f1e9f"
  license :public_domain


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "9891c5e3a931aab73f82ff7f24157e28c6fa9c224497ad29063826f6e5d9bd76"
  end

  def install
    ENV.deparallelize
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    cp test_fixtures("test.jpg"), testpath
    system bin/"jhead", "-autorot", "test.jpg"
  end
end
