class Laszip < Formula
  desc "Lossless LiDAR compression"
  homepage "https://laszip.org/"
  url "https://github.com/LASzip/LASzip/archive/refs/tags/3.5.0.tar.gz"
  sha256 "6e9baac8689dfd2e1502ceafabb20c62b6cd572744d240fb755503fd57c2a6af"
  license "Apache-2.0"
  head "https://github.com/LASzip/LASzip.git", branch: "master"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "8914137443df0e37978212f0a776bf20eb207b5d495acef3d96842402511f743"
  end

  depends_on "cmake" => :build

  # Backport commit to fix setting C++ standard
  patch do
    url "https://github.com/LASzip/LASzip/commit/0bcd1a507be50c845ea62f75d602663b2b3f3b73.patch?full_index=1"
    sha256 "743450909335a7f8170cd40756733b3eae57671b093a5613a42ec26c0d2c99f7"
    type :backport
    resolves "https://github.com/LASzip/LASzip/pull/129"
  end

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    pkgshare.install "example"
  end

  test do
    system ENV.cxx, pkgshare/"example/laszipdllexample.cpp", "-L#{lib}", "-I#{include}/laszip",
                    "-llaszip", "-llaszip_api", "-Wno-format", "-ldl", "-o", "test"
    assert_match "LASzip DLL", shell_output("./test -h 2>&1", 1)
  end
end
