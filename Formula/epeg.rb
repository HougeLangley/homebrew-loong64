class Epeg < Formula
  desc "JPEG/JPG thumbnail scaling"
  homepage "https://github.com/mattes/epeg"
  url "https://github.com/mattes/epeg/archive/refs/tags/v0.9.3.tar.gz"
  sha256 "efcd7e72c530c3ff46f9efd86ec1dbb042e4a55fc5a7ea75e6ade9f83cf77ba3"
  license "MIT-enna"
  head "https://github.com/mattes/epeg.git", branch: "master"


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "ae267de8eb0f4c2a1695a7e54f4f5315283dc4e1397cc9a364981a2fcf3d4967"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "jpeg-turbo"
  depends_on "libexif"

  def install
    system "./autogen.sh", *std_configure_args, "--disable-silent-rules"
    system "make", "install"
  end

  test do
    system bin/"epeg", "--width=1", "--height=1", test_fixtures("test.jpg"), "out.jpg"
    assert_path_exists testpath/"out.jpg"
  end
end
