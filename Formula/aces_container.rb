class AcesContainer < Formula
  desc "Reference implementation of SMPTE ST2065-4"
  homepage "https://github.com/aces-aswf/aces_container"
  url "https://github.com/aces-aswf/aces_container/archive/refs/tags/v1.0.2.tar.gz"
  sha256 "cbbba395d2425251263e4ae05c4829319a3e399a0aee70df2eb9efb6a8afdbae"
  license "AMPAS"


  deprecate! date: "2026-06-05", because: :repo_archived, replacement_formula: "openimageio"
  disable! date: "2027-06-05", because: :repo_archived, replacement_formula: "openimageio"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "0b23e5b0a39bac412c5bfad5a78cceb7de625d2924ae445617f8499fc3f5e293"
  end

  depends_on "cmake" => :build
  depends_on "pkgconf" => :build

  deny_network_access!

  def install
    # Workaround for newer Clang
    ENV.append_to_cflags "-Wno-c++11-narrowing" if DevelopmentTools.clang_build_version >= 1403

    # Workaround to build with CMake 4
    args = %w[-DCMAKE_POLICY_VERSION_MINIMUM=3.5]

    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    (testpath/"test.cpp").write <<~CPP
      #include "aces/aces_Writer.h"

      int main()
      {
          aces_Writer x;
          return 0;
      }
    CPP
    system ENV.cxx, "test.cpp", "-L#{lib}", "-lAcesContainer", "-o", "test"
    system "./test"
  end
end
