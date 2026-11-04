class Libmatroska < Formula
  desc "Extensible, open standard container format for audio/video"
  homepage "https://www.matroska.org/"
  url "https://dl.matroska.org/downloads/libmatroska/libmatroska-1.7.2.tar.xz"
  sha256 "f3e4d406daf7f1399962c43940e4a87de089474d5bcfbf2e6ca516e98bb87cfc"
  license "LGPL-2.1-or-later"
  head "https://github.com/Matroska-Org/libmatroska.git", branch: "master"

  livecheck do
    url "https://dl.matroska.org/downloads/libmatroska/"
    regex(/href=.*?libmatroska[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "0ef954ef8d886b91dd36d226bb5259a4946ec8a1e9e4d08b52b359f6ae180779"
  end

  depends_on "cmake" => :build
  depends_on "libebml"

  deny_network_access!

  def install
    system "cmake", "-S", ".", "-B", "build", "-DBUILD_SHARED_LIBS=ON", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    (testpath/"test.cpp").write <<~CPP
      #include <matroska/KaxVersion.h>
      #include <iostream>

      int main() {
        std::cout << "libmatroska version: " << libmatroska::KaxCodeVersion << std::endl;
        return 0;
      }
    CPP

    system ENV.cxx, "-std=c++11", "test.cpp", "-o", "test", "-I#{include}", "-L#{lib}", "-lmatroska"
    assert_match version.to_s, shell_output("./test")
  end
end
