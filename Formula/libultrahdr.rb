class Libultrahdr < Formula
  desc "Reference codec for the Ultra HDR format"
  homepage "https://developer.android.com/media/platform/hdr-image-format"
  url "https://github.com/google/libultrahdr/archive/refs/tags/v2.0.2.tar.gz"
  sha256 "aa8d193bb887c348c419780511dd03b374f4e07af8812b6d3f80c8537cf1ef2c"
  license "Apache-2.0"
  compatibility_version 2


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "c712cda1648c1e0567cb91344e58991abcce2d9d4c608ab351bbe2652ba9ab82"
  end

  depends_on "cmake" => :build
  depends_on "pkgconf" => :test
  depends_on "jpeg-turbo"

  deny_network_access!

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    assert_match version.to_s, shell_output("pkg-config --modversion libuhdr")

    (testpath/"test.cpp").write <<~CPP
      #include <ultrahdr_api.h>
      #include <iostream>

      int main() {
        uhdr_codec_private_t* encoder = uhdr_create_encoder();
        if (encoder == nullptr) return 1;
        uhdr_release_encoder(encoder);

        std::cout << "encoder ok" << std::endl;
        return 0;
      }
    CPP

    pkg_config_cflags = shell_output("pkg-config --cflags --libs libuhdr").chomp.split
    system ENV.cxx, "test.cpp", "-o", "test", *pkg_config_cflags
    assert_match "encoder ok", shell_output("./test")
  end
end
