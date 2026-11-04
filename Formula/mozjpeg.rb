class Mozjpeg < Formula
  desc "Improved JPEG encoder"
  homepage "https://github.com/mozilla/mozjpeg"
  url "https://github.com/mozilla/mozjpeg/archive/refs/tags/v4.1.5.tar.gz"
  sha256 "9fcbb7171f6ac383f5b391175d6fb3acde5e64c4c4727274eade84ed0998fcc1"
  license all_of: ["IJG", "Zlib", "BSD-3-Clause"]

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end


  keg_only "it conflicts with the standard libjpeg"

  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "c6f57929f3d89749cbfda9550f1d00a2149c43b20c2a898e65cb091646faf564"
  end

  depends_on "cmake" => :build
  depends_on "libpng"

  on_intel do
    depends_on "nasm" => :build
  end

  # Backport fix for CMake 4
  patch do
    url "https://github.com/mozilla/mozjpeg/commit/1644bdb7d2fac66cd0ce25adef7754e008b5bc1e.patch?full_index=1"
    sha256 "bcb23a9c7aec269f472b30b44a31aea5ccc60ea1fc8342325999420e61e4efbd"
    type :backport
  end

  deny_network_access!

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args(install_libdir: lib)
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    system bin/"jpegtran", "-crop", "1x1",
                           "-transpose", "-optimize",
                           "-outfile", "out.jpg",
                           test_fixtures("test.jpg")
  end
end
