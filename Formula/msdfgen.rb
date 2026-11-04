class Msdfgen < Formula
  desc "Multi-channel signed distance field generator"
  homepage "https://github.com/Chlumsky/msdfgen"
  url "https://github.com/Chlumsky/msdfgen/archive/refs/tags/v1.13.tar.gz"
  sha256 "93cd1ad8918c1a78c5c96e82d4f4c77f0eb86c2e7e8579a0967e54196c4b7167"
  license "MIT"
  head "https://github.com/Chlumsky/msdfgen.git", branch: "master"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "f648f0c4dd3d5fa20c9c48db326386cf70603164c29339764d3a29fc90418f77"
  end

  depends_on "cmake" => :build
  depends_on "freetype"
  depends_on "libpng"
  depends_on "tinyxml2"

  deny_network_access!

  def install
    system "cmake", "-S", ".", "-B", "build",
           "-DMSDFGEN_USE_VCPKG=OFF",
           "-DMSDFGEN_USE_SKIA=OFF",
           "-DMSDFGEN_INSTALL=ON",
           *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    system bin/"msdfgen", "msdf",
           "-defineshape", "{ -1, -1; m; -1, +1; y; +1, +1; m; +1, -1; y; # }",
           "-o", "out.png", "-size", "32", "32"
    assert_path_exists testpath/"out.png"
  end
end
