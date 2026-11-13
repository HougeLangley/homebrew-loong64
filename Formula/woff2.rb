class Woff2 < Formula
  desc "Utilities to create and convert Web Open Font File (WOFF) files"
  homepage "https://github.com/google/woff2"
  url "https://github.com/google/woff2/archive/refs/tags/v1.0.2.tar.gz"
  sha256 "add272bb09e6384a4833ffca4896350fdb16e0ca22df68c0384773c67a175594"
  license "MIT"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "d17aa59f07298b42130bdb832540e66c1a8db755db09beaeb0354f43a8a11a85"
  end

  depends_on "cmake" => :build
  depends_on "brotli"

  # AOSC OS / upstream fix: uint8_t needs its own header with modern GCC.
  patch do
    url "https://raw.githubusercontent.com/AOSC-Dev/aosc-os-abbs/1455c7aba657718f19fa5c3488923606b67a03ad/desktop-fonts/woff2/autobuild/patches/0001-fix-build.patch"
    sha256 "327432812ec8959fa09d37bd7821c987725381f03484463610f0efae079f42a8"
  end

  resource "homebrew-roboto_1", :test do
    url "https://fonts.gstatic.com/s/roboto/v18/KFOmCnqEu92Fr1Mu4mxP.ttf"
    sha256 "466989fd178ca6ed13641893b7003e5d6ec36e42c2a816dee71f87b775ea097f"
  end

  resource "homebrew-roboto_2", :test do
    url "https://fonts.gstatic.com/s/roboto/v18/KFOmCnqEu92Fr1Mu72xKKTU1Kvnz.woff2"
    sha256 "90a0ad0b48861588a6e33a5905b17e1219ea87ab6f07ccc41e7c2cddf38967a8"
  end

  allow_network_access! :test

  def install
    args = %W[
      -DCMAKE_INSTALL_NAME_DIR=#{opt_lib}
      -DCMAKE_BUILD_WITH_INSTALL_NAME_DIR=ON
    ]
    # Workaround to build with CMake 4
    args << "-DCMAKE_POLICY_VERSION_MINIMUM=3.5"

    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"

    # Manually install binaries not handled by `make install`
    bin.install "build/woff2_info", "build/woff2_decompress", "build/woff2_compress"
  end

  test do
    # Convert a TTF to WOFF2
    resource("homebrew-roboto_1").stage testpath
    system bin/"woff2_compress", "KFOmCnqEu92Fr1Mu4mxP.ttf"
    output = shell_output("#{bin}/woff2_info KFOmCnqEu92Fr1Mu4mxP.woff2")
    assert_match "WOFF2Header", output

    # Convert a WOFF2 to TTF
    resource("homebrew-roboto_2").stage testpath
    system bin/"woff2_decompress", "KFOmCnqEu92Fr1Mu72xKKTU1Kvnz.woff2"
    output = shell_output("file --brief KFOmCnqEu92Fr1Mu72xKKTU1Kvnz.ttf")
    assert_match(/TrueType font data/i, output)
  end
end
