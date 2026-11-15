class Opensaml < Formula
  desc "Library for Security Assertion Markup Language"
  homepage "https://wiki.shibboleth.net/confluence/display/OpenSAML/Home"
  url "https://shibboleth.net/downloads/c++-opensaml/3.3.1/opensaml-3.3.1.tar.bz2"
  sha256 "d8e24e070fc6bb80682632ca32c8569a9f3ef170ba57e3b82818322e75b6a37e"
  license "Apache-2.0"
  revision 2

  livecheck do
    url "https://shibboleth.net/downloads/c++-opensaml/latest/"
    regex(/href=.*?opensaml[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end



  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "b54081fabd87a097591daf9200e07cb61845230a7798faadf3bb59cd8479e2d4"
  end

  depends_on "pkgconf" => :build
  depends_on "log4shib"
  depends_on "xerces-c"
  depends_on "xml-security-c"
  depends_on "xml-tooling-c"

  def install
    ENV.cxx11

    system "./configure", *std_configure_args
    system "make", "install"

    inreplace lib/"pkgconfig/opensaml.pc", prefix, opt_prefix
  end

  test do
    assert_match "see documentation for usage", shell_output("#{bin}/samlsign 2>&1", 255)
  end
end
