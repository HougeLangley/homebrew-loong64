class Pugixml < Formula
  desc "Light-weight C++ XML processing library"
  homepage "https://pugixml.org/"
  url "https://github.com/zeux/pugixml/releases/download/v1.16/pugixml-1.16.tar.gz"
  sha256 "4cee1ca4aad395170f4c7a07824f3bdd41f28316c6e1e1090a1425b278ec0b4b"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "f886d0daed397eebf4f53c6bfbf0f7070fb373cc877ae7c9bfe1377a7fad3127"
  end

  depends_on "cmake" => :build

  deny_network_access!

  def install
    args = %w[
      -DBUILD_SHARED_LIBS=ON
      -DPUGIXML_BUILD_SHARED_AND_STATIC_LIBS=ON
    ]

    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    (testpath/"test.cpp").write <<~CPP
      #include <pugixml.hpp>
      #include <cassert>
      #include <cstring>

      int main(int argc, char *argv[]) {
        pugi::xml_document doc;
        pugi::xml_parse_result result = doc.load_file("test.xml");

        assert(result);
        assert(strcmp(doc.child_value("root"), "Hello world!") == 0);
      }
    CPP

    (testpath/"test.xml").write <<~XML
      <root>Hello world!</root>
    XML

    system ENV.cxx, "test.cpp", "-o", "test", "-I#{include}", "-L#{lib}", "-lpugixml"
    system "./test"
  end
end
