class Pcapplusplus < Formula
  desc "C++ network sniffing, packet parsing and crafting framework"
  homepage "https://pcapplusplus.github.io"
  url "https://github.com/seladb/PcapPlusPlus/archive/refs/tags/v26.07.tar.gz"
  sha256 "58efbebde9df37134ca6abffdc585562155b7fc0937ced1fd6569a8c93a22ba6"
  license "Unlicense"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end


  bottle do
    rebuild 2
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "f5cf6096d7dba125ec7496e85774f9636c3a5b9d26a8e5a92fff375a6399c373"
  end

  depends_on "cmake" => [:build, :test]
  uses_from_macos "libpcap"

  deny_network_access!

  def install
    cmake_args = %w[
      -DPCAPPP_BUILD_EXAMPLES=OFF
      -DPCAPPP_BUILD_TESTS=OFF
    ]

    system "cmake", "-S", ".", "-B", "build", *cmake_args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    (testpath/"CMakeLists.txt").write <<~CMAKE
      cmake_minimum_required(VERSION 3.12)
      project(TestPcapPlusPlus)
      set(CMAKE_CXX_STANDARD 11)

      find_package(PcapPlusPlus CONFIG REQUIRED)

      add_executable(test test.cpp)
      target_link_libraries(test PUBLIC PcapPlusPlus::Pcap++)
      set_target_properties(test PROPERTIES NO_SYSTEM_FROM_IMPORTED ON)
    CMAKE

    (testpath/"test.cpp").write <<~CPP
      #include <cstdlib>
      #include <pcapplusplus/PcapLiveDeviceList.h>
      int main() {
        const std::vector<pcpp::PcapLiveDevice*>& devList =
          pcpp::PcapLiveDeviceList::getInstance().getPcapLiveDevicesList();
        if (devList.size() > 0) {
          if (devList[0]->getName() == "")
            return 1;
          return 0;
        }
        return 0;
      }
    CPP

    system "cmake", "-S", ".", "-B", "build"
    system "cmake", "--build", "build", "--target", "test"
    system "./build/test"
  end
end
