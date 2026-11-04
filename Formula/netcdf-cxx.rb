class NetcdfCxx < Formula
  desc "C++ libraries and utilities for NetCDF"
  homepage "https://www.unidata.ucar.edu/software/netcdf/"
  url "https://github.com/Unidata/netcdf-cxx4/archive/refs/tags/v4.3.1.tar.gz"
  sha256 "e3fe3d2ec06c1c2772555bf1208d220aab5fee186d04bd265219b0bc7a978edc"
  license "NetCDF"
  revision 3


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "19a79cad170c32a20acc3d0ae133df15257746168712c9f7755bd3a89f42ce7d"
  end

  depends_on "cmake" => :build
  depends_on "hdf5"
  depends_on "netcdf"

  on_macos do
    depends_on "zstd"
  end

  deny_network_access!

  def install
    args = std_cmake_args + %w[
      -DNCXX_ENABLE_TESTS=OFF
      -DENABLE_TESTS=OFF
      -DENABLE_NETCDF_4=ON
      -DENABLE_DOXYGEN=OFF
    ]

    # https://github.com/Unidata/netcdf-cxx4/issues/151#issuecomment-2041111870
    args << "-DHDF5_C_LIBRARY_hdf5=#{formula_opt_lib("hdf5")}"

    # Workaround to build with CMake 4
    args << "-DCMAKE_POLICY_VERSION_MINIMUM=3.5"

    system "cmake", "-S", ".", "-B", "build_shared", *args, "-DBUILD_SHARED_LIBS=ON"
    system "cmake", "--build", "build_shared"
    system "cmake", "--install", "build_shared"

    system "cmake", "-S", ".", "-B", "build_static", *args, "-DBUILD_SHARED_LIBS=OFF"
    system "cmake", "--build", "build_static"
    lib.install "build_static/cxx4/libnetcdf-cxx4.a"

    # Remove shim paths
    inreplace [bin/"ncxx4-config", lib/"libnetcdf-cxx.settings"] do |s|
      s.gsub!(Superenv.shims_path/ENV.cc, ENV.cc, audit_result: false)
      s.gsub!(Superenv.shims_path/ENV.cxx, ENV.cxx, audit_result: false)
    end
  end

  test do
    (testpath/"test.cpp").write <<~CPP
      #include <iostream>
      #include <netcdf>

      constexpr int nx = 6;
      constexpr int ny = 12;

      int main() {
          int dataOut[nx][ny];
          for (int i = 0; i < nx; i++) {
            for (int j = 0; j < ny; j++) {
              dataOut[i][j] = i * ny + j;
            }
          }
          netCDF::NcFile dataFile("simple_xy.nc", netCDF::NcFile::replace);
          auto xDim = dataFile.addDim("x", nx);
          auto yDim = dataFile.addDim("y", ny);
          auto data = dataFile.addVar("data", netCDF::ncInt, {xDim, yDim});
          data.putVar(dataOut);
      }
    CPP
    system ENV.cxx, "test.cpp", "-std=c++11", "-L#{lib}", "-I#{include}", "-lnetcdf-cxx4", "-o", "test"
    system "./test"
  end
end
