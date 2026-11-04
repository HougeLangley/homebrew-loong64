class Flann < Formula
  desc "Fast Library for Approximate Nearest Neighbors"
  homepage "https://github.com/flann-lib/flann"
  url "https://github.com/flann-lib/flann/archive/refs/tags/1.9.2.tar.gz"
  sha256 "e26829bb0017f317d9cc45ab83ddcb8b16d75ada1ae07157006c1e7d601c8824"
  license "BSD-3-Clause"
  revision 4
  compatibility_version 1


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "0362a3e83bbea6e18ba3602dcdb68b7ae4d06cbc5935901bd11fa96d55b07311"
  end

  depends_on "cmake" => :build
  depends_on "pkgconf" => :build
  depends_on "hdf5"
  depends_on "lz4"

  resource "homebrew-dataset", :test do
    url "https://github.com/flann-lib/flann/files/6518483/dataset.zip"
    sha256 "169442be3e9d8c862eb6ae4566306c31ff18406303d87b4d101f367bc5d17afa"
  end

  allow_network_access! :test

  def install
    args = %W[
      -DBUILD_PYTHON_BINDINGS=OFF
      -DBUILD_MATLAB_BINDINGS=OFF
      -DCMAKE_INSTALL_RPATH=#{rpath}
    ]
    # Workaround to build with CMake 4
    args << "-DCMAKE_POLICY_VERSION_MINIMUM=3.5"
    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    testpath.install resource("homebrew-dataset")

    system bin/"flann_example_c"
    system bin/"flann_example_cpp"
  end
end
