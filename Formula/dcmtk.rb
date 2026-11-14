class Dcmtk < Formula
  desc "OFFIS DICOM toolkit command-line utilities"
  homepage "https://dcmtk.org/en/dcmtk/", browsed: "2026-08-06"
  url "https://github.com/DCMTK/dcmtk/archive/refs/tags/DCMTK-3.7.1.tar.gz"
  sha256 "38ac8fceebe201921f6c101493e9611ba12fb5c597db7311df26e95d6d6bf39a"
  license "BSD-3-Clause"
  compatibility_version 1
  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "727eed8638c86edaab01be3fd34ab98bbaacd5ed38fc70b8a7ce93261025725d"
  end

  head "https://git.dcmtk.org/dcmtk.git", branch: "master"

  livecheck do
    url :head
    regex(/^dcmtk[._-]v?(\d+(?:\.\d+)+)$/i)
  end



  depends_on "cmake" => :build

  depends_on "jpeg-turbo"
  depends_on "libpng"
  depends_on "libtiff"
  depends_on "openssl@4"

  uses_from_macos "libxml2"

  on_linux do
    depends_on "zlib-ng-compat"
  end

  deny_network_access!

  def install
    args = std_cmake_args + ["-DDCMTK_WITH_ICU=OFF"]

    system "cmake", "-S", ".", "-B", "build/shared", *args,
                    "-DBUILD_SHARED_LIBS=ON",
                    "-DCMAKE_INSTALL_RPATH=#{rpath}"
    system "cmake", "--build", "build/shared"
    system "cmake", "--install", "build/shared"

    system "cmake", "-S", ".", "-B", "build/static", *args,
                    "-DBUILD_SHARED_LIBS=OFF"
    system "cmake", "--build", "build/static"
    lib.install Dir["build/static/lib/*.a"]

    inreplace lib/"cmake/dcmtk/DCMTKConfig.cmake", "#{Superenv.shims_path}/", ""
  end

  test do
    system bin/"pdf2dcm", "--verbose",
           test_fixtures("test.pdf"), testpath/"out.dcm"
    system bin/"dcmftest", testpath/"out.dcm"
  end
end
