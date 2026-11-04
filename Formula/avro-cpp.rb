class AvroCpp < Formula
  desc "Data serialization system"
  homepage "https://avro.apache.org/"
  # TODO: Remove fmt in the next release
  # https://github.com/apache/avro/commit/d77446e5d05cd68c28d09c1af800a428dea34e03
  url "https://www.apache.org/dyn/closer.lua?path=avro/avro-1.12.2/cpp/avro-cpp-1.12.2.tar.gz"
  mirror "https://archive.apache.org/dist/avro/avro-1.12.2/cpp/avro-cpp-1.12.2.tar.gz"
  sha256 "5e4cea5d9dc59bbc0e3e1967fd8f8a86b4cb7c1452c4b252561b8137e949f6fd"
  license "Apache-2.0"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "8a49ce6f8ee3abf3901e89e9184076525d0bb3086f75865f471d72f6b7eb0d08"
  end

  depends_on "cmake" => :build
  depends_on "fmt" => [:build, :test] # needed for headers
  depends_on "pkgconf" => :build
  depends_on "zstd"

  on_linux do
    depends_on "zlib-ng-compat"
  end

  # Add missing cmake file from git
  resource "avro-cpp-config.cmake.in" do
    url "https://github.com/apache/avro/raw/refs/tags/release-1.12.2/lang/c++/cmake/avro-cpp-config.cmake.in"
    sha256 "0edd19477321eea574be10972f65fc958bd7ae907de1a3974d9bffec238a01e6"

    livecheck do
      formula :parent
    end
  end

  deny_network_access!

  def install
    (buildpath/"cmake").install resource("avro-cpp-config.cmake.in")

    system "cmake", "-S", ".", "-B", "build", "-DAVRO_BUILD_TESTS=OFF", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    (testpath/"cpx.json").write <<~JSON
      {
          "type": "record",
          "name": "cpx",
          "fields" : [
              {"name": "re", "type": "double"},
              {"name": "im", "type" : "double"}
          ]
      }
    JSON

    (testpath/"test.cpp").write <<~CPP
      #include "cpx.hh"

      int main() {
        cpx::cpx number;
        return 0;
      }
    CPP

    system bin/"avrogencpp", "-i", "cpx.json", "-o", "cpx.hh", "-n", "cpx"
    system ENV.cxx, "test.cpp", "-std=c++17", "-o", "test"
    system "./test"
  end
end
