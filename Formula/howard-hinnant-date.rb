class HowardHinnantDate < Formula
  desc "C++ library for date and time operations based on <chrono>"
  homepage "https://github.com/HowardHinnant/date"
  url "https://github.com/HowardHinnant/date/archive/refs/tags/v3.0.5.tar.gz"
  sha256 "ef786edc203daec76475825640b3af247bd08e31fc52217e5ce8f76107b4bb05"
  license "MIT"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "0c46a05ced22047f664a85525498b53e02ce8cb247288b94234c0e60adb946d9"
  end

  depends_on "cmake" => :build

  def install
    args = %w[
      -DENABLE_DATE_TESTING=OFF
      -DUSE_SYSTEM_TZ_DB=ON
      -DBUILD_SHARED_LIBS=ON
      -DBUILD_TZ_LIB=ON
    ]

    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    (testpath/"test.cpp").write <<~CPP
      #include "date/tz.h"
      #include <iostream>

      int main() {
        auto t = date::make_zoned(date::current_zone(), std::chrono::system_clock::now());
        std::cout << t << std::endl;
      }
    CPP
    system ENV.cxx, "test.cpp", "-std=c++1y", "-L#{lib}", "-ldate-tz", "-o", "test"
    system "./test"
  end
end
