class Htmldoc < Formula
  desc "Convert HTML to PDF or PostScript"
  homepage "https://www.msweet.org/htmldoc/"
  url "https://github.com/michaelrsweet/htmldoc/releases/download/v1.9.24/htmldoc-1.9.24-source.zip"
  sha256 "1ae2803f82a4fac7b4f8f80f036d82fdca8f467fb89f4df5d07e7889192e678f"
  license "GPL-2.0-only"
  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "5c9b69b4c396cd33bc4fb4a5bb9020bf41c80b5b642ad4ef99063dd69ed308a3"
  end

  head "https://github.com/michaelrsweet/htmldoc.git", branch: "master"



  depends_on "pkgconf" => :build
  depends_on "jpeg-turbo"
  depends_on "libpng"

  uses_from_macos "cups"

  on_linux do
    depends_on "zlib-ng-compat"
  end

  def install
    system "./configure", "--without-gui", *std_configure_args
    system "make"
    system "make", "install"
  end

  test do
    system bin/"htmldoc", "--version"
  end
end
