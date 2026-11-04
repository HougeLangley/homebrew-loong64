class UniAlgo < Formula
  desc "Unicode Algorithms Implementation for C/C++"
  homepage "https://github.com/uni-algo/uni-algo"
  url "https://github.com/uni-algo/uni-algo/archive/refs/tags/v1.2.0.tar.gz"
  sha256 "f2a1539cd8635bc6088d05144a73ecfe7b4d74ee0361fabed6f87f9f19e74ca9"
  license "MIT"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "ec5288cb121016d171b8db6ebb19f205b3b122c954b8f6c4ab16d826795f7d9f"
  end

  depends_on "cmake" => [:build, :test]

  deny_network_access!

  def install
    system "cmake", "-S", ".", "-B", "build", "-DBUILD_SHARED_LIBS=ON", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    (testpath/"CMakeLists.txt").write <<~CMAKE
      cmake_minimum_required(VERSION 4.0)
      project(utf8_norm LANGUAGES CXX)
      find_package(uni-algo CONFIG REQUIRED)
      add_executable(utf8_norm utf8_norm.cpp)
      target_link_libraries(utf8_norm PRIVATE uni-algo::uni-algo)
    CMAKE

    (testpath/"utf8_norm.cpp").write <<~CPP
      #include <uni_algo/norm.h>
      int main() {
        return (una::norm::to_nfc_utf8("W\\u0302") == "Ŵ") ? 0 : 1;
      }
    CPP

    system "cmake", "-S", ".", "-B", "build", "-DCMAKE_PREFIX_PATH:STRING=#{opt_lib}"
    system "cmake", "--build", "build"
    system "build/utf8_norm"
  end
end
