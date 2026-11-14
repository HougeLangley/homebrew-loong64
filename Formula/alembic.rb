class Alembic < Formula
  desc "Open computer graphics interchange framework"
  homepage "http://www.alembic.io/"
  url "https://github.com/alembic/alembic/archive/refs/tags/1.8.12.tar.gz"
  sha256 "b6d916c40446e8c502c84273092ab3d98f3f7f6094f8a2b8203d23e2f1d2a4a0"
  license "BSD-3-Clause"
  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "a701b7f58eb130c57c30715122c658e5f0ff06f2816e5ed7e86e1b82cd6e1deb"
  end

  head "https://github.com/alembic/alembic.git", branch: "master"



  depends_on "cmake" => :build
  depends_on "hdf5"
  depends_on "imath"

  on_linux do
    depends_on "zlib-ng-compat"
  end

  deny_network_access!

  def install
    args = %w[
      -DUSE_PRMAN=OFF
      -DUSE_ARNOLD=OFF
      -DUSE_MAYA=OFF
      -DUSE_PYALEMBIC=OFF
      -DUSE_HDF5=ON
    ]
    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"

    pkgshare.install "prman/Tests/testdata/cube.abc"
  end

  test do
    assert_match "root", shell_output("#{bin}/abcls #{pkgshare}/cube.abc")
  end
end
