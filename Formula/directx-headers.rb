class DirectxHeaders < Formula
  desc "Official DirectX headers available under an open source license"
  homepage "https://devblogs.microsoft.com/directx/"
  url "https://github.com/microsoft/DirectX-Headers/archive/refs/tags/v1.619.5.tar.gz"
  sha256 "24a0b7d8079a2dbbc90753c0d8bc812040d052acce2302e69a97c5d873b313b8"
  license "MIT"


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "d6d9e5d773dda77e9d3c131a5d3c9ef177603cc0f7bf8684b57595e1d1026e2b"
  end

  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "mingw-w64" => :test

  resource "test.cpp", :test do
    url "https://raw.githubusercontent.com/microsoft/DirectX-Headers/a7d19030b872967c4224607c454273a2e65a5ed4/test/test.cpp"
    sha256 "6ff077a364a5f0f96b675d21aa8f053711fbef75bfdb193b44cc10b8475e2294"
  end

  def install
    system "meson", "setup", "build", "-Dbuild-test=false", *std_meson_args
    system "meson", "compile", "-C", "build"
    system "meson", "install", "-C", "build"
  end

  test do
    resource("test.cpp").stage(testpath)

    ENV.remove_macosxsdk if OS.mac?

    system formula_opt_bin("mingw-w64")/"x86_64-w64-mingw32-g++", "-I#{include}", "-c", "test.cpp"
  end
end
