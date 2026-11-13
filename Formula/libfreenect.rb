class Libfreenect < Formula
  desc "Drivers and libraries for the Xbox Kinect device"
  homepage "https://openkinect.org/"
  url "https://github.com/OpenKinect/libfreenect/archive/refs/tags/v0.7.5.tar.gz"
  sha256 "3c668053db726206a8c3a92e92e91ef7a64407968f422b9c4b828d0fd234c866"
  license any_of: ["Apache-2.0", "GPL-2.0-only"]
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "932338696702ea8389aaaf476535c6bd29d0d6d17ba768a23be25b684e2e7e5d"
  end

  head "https://github.com/OpenKinect/libfreenect.git", branch: "master"


  depends_on "cmake" => :build
  depends_on "libusb"

  deny_network_access!

  def install
    # OpenNI2 driver ships x86_64-only externals and is not needed on LoongArch.
    ENV.append "CXXFLAGS", "-include cstring"
    args = %W[
      -DBUILD_OPENNI2_DRIVER=OFF
      -DCMAKE_INSTALL_RPATH=#{rpath}
    ]

    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <stdio.h>
      #include <libfreenect/libfreenect.h>

      int main() {
        freenect_context *ctx;
        if (freenect_init(&ctx, NULL) < 0) {
          printf("Failed to initialize libfreenect\\n");
          return 1;
        }
        printf("libfreenect initialized successfully\\n");
        freenect_shutdown(ctx);
        return 0;
      }
    C

    system ENV.cc, "test.c", "-o", "test", "-I#{include}", "-L#{lib}", "-lfreenect"
    system "./test"

    system bin/"fakenect-record", "-h"
  end
end
