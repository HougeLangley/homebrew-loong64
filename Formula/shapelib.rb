class Shapelib < Formula
  desc "Library for reading and writing ArcView Shapefiles"
  homepage "http://shapelib.maptools.org/"
  url "https://download.osgeo.org/shapelib/shapelib-1.6.3.tar.gz"
  sha256 "3ff5ead18ca6d2fe249f0e80b361e1ad6782165115268ed4a58c780a60c1e0eb"
  license any_of: ["LGPL-2.0-or-later", "MIT"]

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "425810f7fba0469a0d50235106b40346c394754aa03923d6b22039ee83689aa5"
  end

  livecheck do
    url "https://download.osgeo.org/shapelib/"
    regex(/href=.*?shapelib[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end



  depends_on "cmake" => :build

  deny_network_access!

  def install
    # shapelib's CMake scripts interpret `CMAKE_INSTALL_LIBDIR=lib` as relative
    # to the current directory, i.e. `CMAKE_INSTALL_LIBDIR:PATH=$(pwd)/lib`
    system "cmake", "-S", ".", "-B", "build", "-DCMAKE_INSTALL_RPATH=#{rpath}", *std_cmake_args(install_libdir: lib)
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    assert_match "shp_file", shell_output("#{bin}/shptreedump", 1)
  end
end
