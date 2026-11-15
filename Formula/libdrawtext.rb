class Libdrawtext < Formula
  desc "Library for anti-aliased text rendering in OpenGL"
  homepage "http://nuclear.mutantstargoat.com/sw/libdrawtext/"
  url "https://github.com/jtsiomb/libdrawtext/releases/download/v0.6/libdrawtext-0.6.tar.gz"
  sha256 "714d94473622d756bfe7d70ad6340db3de7cc48f4f356a060e3cb48900c6da01"
  license "LGPL-3.0-or-later"
  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "1ef947fe17f4f08b66df8a0b6cf0af85315ac5850509443d57374c5289879273"
  end

  head "https://github.com/jtsiomb/libdrawtext.git", branch: "master"



  depends_on "pkgconf" => :build
  depends_on "freetype"

  on_linux do
    depends_on "mesa"
    depends_on "mesa-glu"
  end

  def install
    system "./configure", "--disable-dbg", "--enable-opt", "--prefix=#{prefix}"

    # Avoid errors with Xcode 15
    inreplace "Makefile", "CFLAGS =", "CFLAGS = -Wno-implicit-function-declaration"

    system "make", "install"
    system "make", "-C", "tools/font2glyphmap"
    system "make", "-C", "tools/font2glyphmap", "PREFIX=#{prefix}", "install"
    pkgshare.install "examples"
  end

  test do
    ext = "ttf"
    font_name = "DejaVuSans"
    font_path = "/usr/share/fonts/truetype/dejavu"
    if OS.mac?
      ext = "otf"
      font_name = "LastResort"
      font_path = "/System/Library/Fonts"
    end

    cp "#{font_path}/#{font_name}.#{ext}", testpath
    system bin/"font2glyphmap", "#{font_name}.#{ext}"
    assert_match(/P5\n512 (256|512)\n# size: 12/, shell_output("head -3 #{font_name}_s12.glyphmap"))
  end
end
