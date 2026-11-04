class Libzen < Formula
  desc "Shared library for libmediainfo"
  homepage "https://github.com/MediaArea/ZenLib"
  license "Zlib"
  revision 1
  compatibility_version 1
  head "https://github.com/MediaArea/ZenLib.git", branch: "master"

  stable do
    url "https://mediaarea.net/download/source/libzen/0.4.41/libzen_0.4.41.tar.bz2"
    sha256 "eb237d7d3dca6dc6ba068719420a27de0934a783ccaeb2867562b35af3901e2d"

    # Fixes build with CMake 4.0+. Remove on next release.
    patch do
      url "https://github.com/MediaArea/ZenLib/commit/2350bc442963ba9e4ddcf4e67ba1ff2c95d44635.patch?full_index=1"
      sha256 "fea2e76c5017ab98f2501dfdc24bedf4682b7336544529a08d9e1827c4de6bae"
      type :backport
      resolves "https://github.com/MediaArea/ZenLib/pull/174"
    end
  end

  livecheck do
    url "https://mediaarea.net/en/MediaInfo/Download/Source"
    regex(/href=.*?libzen[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "4176fc15f5cfd9d82893285a30d8c9d4b477448fb1b0176c357f75c3d6edfd21"
  end

  depends_on "cmake" => :build
  depends_on "pkgconf" => :build

  # These files used to be distributed as part of the media-info formula
  link_overwrite "include/ZenLib/*"
  link_overwrite "lib/pkgconfig/libzen.pc"
  link_overwrite "lib/libzen.*"

  deny_network_access!

  def install
    system "cmake", "-S", "Project/CMake", "-B", "build", "-DBUILD_SHARED_LIBS=ON", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    (testpath/"test.cc").write <<~CPP
      #include <ZenLib/Ztring.h>
      #include <iostream>
      int main() {
        ZenLib::Ztring myString = ZenLib::Ztring().From_UTF8("Hello, ZenLib!");
        std::cout << myString.To_UTF8() << std::endl;
        return 0;
      }
    CPP
    system ENV.cxx, "-std=c++17", "test.cc", "-I#{include}", "-L#{lib}", "-lzen", "-o", "test"
    system "./test"
  end
end
