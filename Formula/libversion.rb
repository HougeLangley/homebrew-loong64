class Libversion < Formula
  desc "Advanced version string comparison library"
  homepage "https://github.com/repology/libversion"
  url "https://github.com/repology/libversion/archive/refs/tags/3.0.4.tar.gz"
  sha256 "48c2a4a98b6f220dedd535979f1e9ab83f9bf869e06c0f5e7bb1be6d2e662fee"
  license "MIT"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "7dbd6b157a8f6cd743f52e6fd631c9e9ecd29a256799c6c4961f985c59ec1436"
  end

  depends_on "cmake" => :build

  deny_network_access!

  def install
    system "cmake", "-S", ".", "-B", "build", "-DCMAKE_INSTALL_RPATH=#{rpath}", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    assert_equal "=", shell_output("#{bin}/version_compare 1.0 1.0.0").chomp
    assert_equal "<", shell_output("#{bin}/version_compare 1.1p1 1.1").chomp
    assert_equal ">", shell_output("#{bin}/version_compare -p 1.1p1 1.1").chomp
  end
end
