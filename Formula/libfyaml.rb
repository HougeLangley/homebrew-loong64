class Libfyaml < Formula
  desc "Fully feature complete YAML parser and emitter"
  homepage "https://github.com/pantoniou/libfyaml"
  url "https://github.com/pantoniou/libfyaml/releases/download/v0.9.6/libfyaml-0.9.6.tar.gz"
  sha256 "a59cc3331e2eb903ec36933ad52a45888041cac31e44f553a00511131242c483"
  license "MIT"
  compatibility_version 1


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "7f8d3125a610ac1f7096b2c71e272cdba77846b8448bd5efc84547ae34ebf5ed"
  end

  depends_on "cmake" => :build

  # TODO: Remove patch in next release
  patch do
    url "https://github.com/pantoniou/libfyaml/commit/1026d76850909dc9b1c5f95b8cd94e865a313fd5.patch?full_index=1"
    sha256 "05e07134edfae8c4d6b81fd25b013c471a3790736f61d6888035409d570ce636"
    type :backport
    resolves "https://github.com/pantoniou/libfyaml/pull/267"
  end

  deny_network_access!

  def install
    system "cmake", "-S", ".", "-B", "build", "-DCMAKE_INSTALL_RPATH=#{rpath}", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    (testpath/"test.cpp").write <<~CPP
      #ifdef HAVE_CONFIG_H
      #include "config.h"
      #endif

      #include <iostream>
      #include <libfyaml.h>

      int main(int argc, char *argv[])
      {
        std::cout << fy_library_version() << std::endl;
        return EXIT_SUCCESS;
      }
    CPP
    system ENV.cxx, "test.cpp", "-I#{include}", "-L#{lib}", "-lfyaml", "-o", "test"
    assert_equal 0, $CHILD_STATUS.exitstatus
    assert_equal version.to_s, shell_output("#{testpath}/test").strip
    assert_equal version.to_s, shell_output("#{bin}/fy-tool --version").strip
  end
end
