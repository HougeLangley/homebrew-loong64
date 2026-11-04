class Openmama < Formula
  desc "Open source high performance messaging API for various Market Data sources"
  homepage "https://openmama.finos.org"
  url "https://github.com/finos/OpenMAMA/archive/refs/tags/OpenMAMA-6.3.2-release.tar.gz"
  sha256 "5c09b5c73467c4122fe275c0f880c70e4b9f6f8d1ecbaa1aeeac7d8195d9ffef"
  license "LGPL-2.1-only"

  livecheck do
    url :stable
    regex(/^OpenMAMA[._-]v?(\d+(?:\.\d+)+)(?:-release)?$/i)
  end


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "68177a9ef228cef1a9f7a2c97602d8f318cf04d6992175e326023dfcbac88eaa"
  end

  depends_on "cmake" => :build
  depends_on "apr"
  depends_on "apr-util"
  depends_on "libevent"
  depends_on "qpid-proton"

  uses_from_macos "flex" => :build
  uses_from_macos "ncurses"

  # UUID is provided by util-linux on Linux.
  on_linux do
    depends_on "util-linux"
  end

  deny_network_access!

  def install
    args = %W[
      -DAPR_ROOT=#{formula_opt_prefix("apr")}
      -DAPRUTIL_ROOT=#{formula_opt_prefix("apr-util")}
      -DPROTON_ROOT=#{formula_opt_prefix("qpid-proton")}
      -DCMAKE_INSTALL_RPATH=#{rpath}
      -DINSTALL_RUNTIME_DEPENDENCIES=OFF
      -DWITH_TESTTOOLS=OFF
      -DOPENMAMA_VERSION=#{version}
    ]
    args += %W[-DUUID_INCLUDE_DIRS=#{MacOS.sdk_for_formula(self).path}/usr/include -DUUID_LIBRARIES=c] if OS.mac?

    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    system bin/"mamalistenc", "-?"

    (testpath/"test.c").write <<~C
      #include <mama/mama.h>
      #include <stdio.h>
      int main() {
          mamaBridge bridge;
          fclose(stderr);
          mama_status status = mama_loadBridge(&bridge, "qpid");
          if (status != MAMA_STATUS_OK) return 1;
          const char* version = mama_getVersion(bridge);
          if (NULL == version) return 2;
          printf("%s\\n", version);
          return 0;
      }
    C

    system ENV.cc, "test.c", "-I#{include}", "-L#{lib}", "-lmama", "-o", "test"
    assert_includes shell_output("./test"), version.to_s
  end
end
