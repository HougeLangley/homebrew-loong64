class Xdelta < Formula
  desc "Binary diff, differential compression tools"
  homepage "https://github.com/jmacd/xdelta"
  url "https://github.com/jmacd/xdelta/archive/refs/tags/v3.2.2.tar.gz"
  sha256 "995319ccb7fe721a523fb3142376f5813093685b1cc302d07018ca97d2584af2"
  license "GPL-2.0-or-later"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "c458c1f1fa9f1f587901f7f354614e39fb548ff109f599ded833ee2238971e71"
  end

  depends_on "cmake" => :build
  depends_on "blake3"
  depends_on "xz"

  deny_network_access!

  def install
    # Fix library target to the same as `blake3` formula.
    inreplace "xdelta3/CMakeLists.txt",
              "set(XD3_ARMOR_LIBRARIES blake3)",
              "set(XD3_ARMOR_LIBRARIES BLAKE3::blake3)"

    args = %w[
      -DXD3_BUILD_TESTS=OFF
      -DXD3_LZMA_MODE=on
      -DHOMEBREW_ALLOW_FETCHCONTENT=ON
      -DFETCHCONTENT_FULLY_DISCONNECTED=ON
      -DFETCHCONTENT_TRY_FIND_PACKAGE_MODE=ALWAYS
    ]
    system "cmake", "-S", "xdelta3", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    system bin/"xdelta3", "config"
  end
end
