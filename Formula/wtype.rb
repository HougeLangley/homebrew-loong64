class Wtype < Formula
  desc "Xdotool type for wayland"
  homepage "https://github.com/atx/wtype"
  url "https://github.com/atx/wtype/archive/refs/tags/v0.5.tar.gz"
  sha256 "684308ac8b47c510dddf4abac3aef86b4f7b8c0e165389a40608679a7a5b77ed"
  license "MIT"



  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "5a1697f0e1d01dfb7f0f5d35fe2c430f67d72f8322cd4ca47bce28348853f0a2"
  end

  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkgconf" => :build
  depends_on "libxkbcommon"
  depends_on :linux
  depends_on "wayland"
  depends_on "wayland-protocols"

  def install
    system "meson", "setup", "build", *std_meson_args
    system "meson", "compile", "-C", "build", "--verbose"
    system "meson", "install", "-C", "build"
  end

  test do
    assert_match "Wayland connection failed", shell_output("#{bin}/wtype test 2>&1", 1)
  end
end
