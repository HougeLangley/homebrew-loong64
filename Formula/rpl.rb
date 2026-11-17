class Rpl < Formula
  desc "Text replacement utility"
  homepage "https://github.com/rrthomas/rpl"
  url "https://github.com/rrthomas/rpl/releases/download/v2.1.2/rpl-2.1.2.tar.gz"
  sha256 "7994ef8663a51779ab1fb3a730cf2ae6cda81cc905b6db9ae0e858f63cb8b3e1"
  license "GPL-3.0-or-later"



  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "bb35d03c32f83b869f2ac892c54d84c0d03960279cfde4926a0b86f3085235eb"
  end

  depends_on "help2man" => :build
  depends_on "pkgconf" => :build
  depends_on "glib"
  depends_on "pcre2"
  depends_on "uchardet"

  on_macos do
    depends_on "gettext"
  end

  def install
    system "./configure", "--disable-silent-rules", *std_configure_args
    system "make", "install"
  end

  test do
    (testpath/"test").write "I like water."

    system bin/"rpl", "-v", "water", "beer", "test"
    assert_equal "I like beer.", (testpath/"test").read
  end
end
