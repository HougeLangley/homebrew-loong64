class Enkits < Formula
  desc "C and C++ Task Scheduler for creating parallel programs"
  homepage "https://github.com/dougbinks/enkiTS"
  url "https://github.com/dougbinks/enkiTS/archive/refs/tags/v1.12.tar.gz"
  sha256 "8373b6199d56816bd3ba58432eae74e2ebd5afcfdffb723073cc34730b189fd5"
  license "Zlib"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "ff5267476d99f898e18bf0d1fe2df647e582de56f6662bb08f038f7f6ab8bf40"
  end

  depends_on "cmake" => :build

  deny_network_access!

  def install
    args = %w[
      -DENKITS_BUILD_EXAMPLES=OFF
      -DENKITS_INSTALL=ON
      -DENKITS_BUILD_SHARED=ON
    ]
    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    pkgshare.install "example"
  end

  test do
    system ENV.cxx, pkgshare/"example/PinnedTask.cpp",
      "-std=c++11", "-I#{include}/enkiTS", "-L#{lib}", "-lenkiTS", "-o", "example"
    output = shell_output("./example")
    assert_match("This will run on the main thread", output)
    assert_match(/This could run on any thread, currently thread \d/, output)
  end
end
