class Hqx < Formula
  desc "Magnification filter designed for pixel art"
  homepage "https://github.com/grom358/hqx"
  url "https://github.com/grom358/hqx.git",
      tag:      "v1.2",
      revision: "124c9399fa136fb0f743417ca27dfa2ca2860c2d"
  license "LGPL-2.1-or-later"


  bottle do
    rebuild 4
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "d0332dbb4b80de7e013f9098bce3f2af46a2c6ed3fa9e16db360c7bbf4d33d70"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkgconf" => :build
  depends_on "php" => :test
  depends_on "devil"

  deny_network_access!

  def install
    ENV.deparallelize
    system "autoreconf", "--force", "--install", "--verbose"
    system "./configure", *std_configure_args
    system "make", "install"
  end

  test do
    system bin/"hqx", test_fixtures("test.jpg"), "out.jpg"
    output = pipe_output("php -r \"print_r(getimagesize('file://#{testpath}/out.jpg'));\"")
    assert_equal <<~EOS, output
      Array
      (
          [0] => 4
          [1] => 4
          [2] => 2
          [3] => width="4" height="4"
          [bits] => 8
          [channels] => 3
          [mime] => image/jpeg
          [width_unit] => px
          [height_unit] => px
      )
    EOS
  end
end
