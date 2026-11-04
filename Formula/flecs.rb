class Flecs < Formula
  desc "Fast entity component system for C & C++"
  homepage "https://www.flecs.dev"
  url "https://github.com/SanderMertens/flecs/archive/refs/tags/v4.1.6.tar.gz"
  sha256 "29ccf56961b7ffbd38cce2227a06c0722c7df464422e86619a65ee37bb31bae7"
  license "MIT"
  head "https://github.com/SanderMertens/flecs.git", branch: "master"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "b0b9bd5f89f8834e9840f566c4623f59d8547ee2a0df17192b360c1d5427f575"
  end

  depends_on "cmake" => [:build, :test]

  deny_network_access!

  def install
    system "cmake", "-S", ".", "-B", "builddir", *std_cmake_args
    system "cmake", "--build", "builddir"
    system "cmake", "--install", "builddir"
  end

  test do
    (testpath/"main.c").write <<~C
      #include <flecs.h>

      int main(void) {
          ecs_world_t *world = ecs_init();
          ecs_fini(world);
          return 0;
      }
    C

    (testpath/"CMakeLists.txt").write <<~CMAKE
      cmake_minimum_required (VERSION #{Formula["cmake"].version})

      project(test LANGUAGES C)
      set(CMAKE_C_STANDARD 11)

      find_package(flecs CONFIG REQUIRED)
      add_executable(test main.c)
      target_link_libraries(test PRIVATE flecs::flecs)
    CMAKE

    system "cmake", "-S", ".", "-B", "build"
    system "cmake", "--build", "build"
    system "./build/test"
  end
end
