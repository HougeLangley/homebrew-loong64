class Pngcheck < Formula
  desc "Print info and check PNG, JNG, and MNG files"
  homepage "https://github.com/pnggroup/pngcheck"
  url "https://github.com/pnggroup/pngcheck/archive/refs/tags/v4.0.1.tar.gz"
  sha256 "a24ac2348efca5895e9d6f53fd316f3d5c409ab92a74b2b8106541759304da53"
  license "HPND"


  bottle do
    rebuild 2
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "203e7112e83cf6d2bd2ec1957e55e8e679a2a24f5f7c2cdf5070aa41bd2afaf5"
  end

  depends_on "cmake" => :build

  on_linux do
    depends_on "zlib-ng-compat"
  end

  deny_network_access!

  def install
    # Remove files only needed on non-Unix. Doesn't need to be removed as CMake handles it
    # but they have different or dubious licenses so let's be explicit to prove that the above license DSL is correct.
    rm_r "amiga"
    rm_r "third_party"

    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    system bin/"pngcheck", test_fixtures("test.png")
  end
end
