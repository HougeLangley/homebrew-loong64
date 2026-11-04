class Libuvc < Formula
  desc "Cross-platform library for USB video devices"
  homepage "https://libuvc.github.io/"
  url "https://github.com/libuvc/libuvc/archive/refs/tags/v0.0.8.tar.gz"
  sha256 "abe134716f4c53fe60db2004b42adf6af60e64e45808135acfa4311454371ece"
  license "BSD-3-Clause"
  head "https://github.com/libuvc/libuvc.git", branch: "master"


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "ea30830d9252ceca27f2115a829155fdc4541a76bfe5846a65c176b8aa9aeda7"
  end

  depends_on "cmake" => :build
  depends_on "pkgconf" => [:build, :test]
  depends_on "libusb"

  deny_network_access!

  def install
    # Workaround to build with CMake 4
    args = %w[-DCMAKE_POLICY_VERSION_MINIMUM=3.5]
    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <libuvc/libuvc.h>
      int main() {
        uvc_context_t *ctx;
        uvc_error_t res = uvc_init(&ctx, NULL);
        if (res != UVC_SUCCESS) return 1;
        uvc_exit(ctx);
        return 0;
      }
    C

    flags = shell_output("pkgconf --cflags --libs libuvc").strip.split
    system ENV.cc, "test.c", "-o", "test", *flags
    system "./test"
  end
end
