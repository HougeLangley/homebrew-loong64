class Libmonome < Formula
  desc "Library for easy interaction with monome devices"
  homepage "https://monome.org/"
  url "https://github.com/monome/libmonome/archive/refs/tags/v1.4.11.tar.gz"
  sha256 "8eff3e5fe159d2a718e578808b129a8603b45e91c54f194704c20916acf181d6"
  license "ISC"
  compatibility_version 1
  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "30b251971d763ee59cc73e0a1e07a9ed95cd8985ffef9b3bb1551e5e431d999d"
  end

  head "https://github.com/monome/libmonome.git", branch: "main"



  depends_on "cmake" => [:build, :test]
  depends_on "liblo"

  uses_from_macos "python" => :build

  on_linux do
    depends_on "pkgconf" => :build
    depends_on "systemd" # for libudev
  end

  deny_network_access!

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"

    pkgshare.install Dir["examples/*.c"]
  end

  test do
    cp pkgshare/"simple.c", "simple.c"
    (testpath/"CMakeLists.txt").write <<~EOS
      add_executable(simple ${CMAKE_CURRENT_SOURCE_DIR}/simple.c)
      target_link_libraries(simple PRIVATE monome)
    EOS

    system "cmake", "-S", ".", "-B", "build"
    system "cmake", "--build", "build"

    # assert no output and failure for missing device
    assert_equal "", shell_output("build/simple", 255)
  end
end
