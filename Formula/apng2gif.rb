class Apng2gif < Formula
  desc "Convert APNG animations into animated GIF format"
  homepage "https://apng2gif.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/apng2gif/1.8/apng2gif-1.8-src.zip"
  sha256 "9a07e386017dc696573cd7bc7b46b2575c06da0bc68c3c4f1c24a4b39cdedd4d"
  license all_of: ["libpng-2.0", "Zlib"]


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "351a9ac006a10f0b5b7ed1f85526b18c94568f2bfdf1bade6719ca769985b1c8"
  end

  depends_on "libpng"

  def install
    system "make"
    bin.install "apng2gif"
  end

  test do
    cp test_fixtures("test.png"), testpath/"test.png"
    system bin/"apng2gif", testpath/"test.png"
    assert_path_exists testpath/"test.gif", "Failed to create test.gif"
  end
end
