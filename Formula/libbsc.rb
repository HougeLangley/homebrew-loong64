class Libbsc < Formula
  desc "High performance block-sorting data compression library"
  homepage "http://libbsc.com"
  url "https://github.com/IlyaGrebnov/libbsc/archive/refs/tags/v3.4.0.tar.gz"
  sha256 "b0081d225f6e5e1bac50d16ad4a784ca48cb28b1f0f4fd90a10310725c7e6d7c"
  license "Apache-2.0"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "2af34f0fdc88012b53ef302960da204e6a22b74ce73a73b4ecc60e8da4965c81"
  end

  depends_on "cmake" => :build

  on_macos do
    depends_on "libomp"
  end

  conflicts_with "bsc", because: "both install `bsc` binaries"

  deny_network_access!

  def install
    args = %W[
      -DBSC_ENABLE_NATIVE_COMPILATION=OFF
      -DBSC_BUILD_SHARED_LIB=ON
      -DCMAKE_INSTALL_RPATH=#{rpath}
    ]
    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    system bin/"bsc", "e", test_fixtures("test.tiff"), "test.tiff.bsc"
    system bin/"bsc", "d", "test.tiff.bsc", "test.tiff"
    assert_equal Digest::SHA256.hexdigest(test_fixtures("test.tiff").read),
                 Digest::SHA256.hexdigest((testpath/"test.tiff").read)
  end
end
