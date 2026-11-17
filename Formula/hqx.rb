class Hqx < Formula
  desc "Magnification filter designed for pixel art"
  homepage "https://github.com/grom358/hqx"
  url "https://github.com/grom358/hqx.git",
      tag:      "v1.2",
      revision: "124c9399fa136fb0f743417ca27dfa2ca2860c2d"
  license "LGPL-2.1-or-later"



  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "de7c46030f230378fc37d853077b7c0f84ad729cb45d85be05c11958bc33e0a3"
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
