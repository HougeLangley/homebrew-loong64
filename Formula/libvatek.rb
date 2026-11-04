class Libvatek < Formula
  desc "User library to control VATek chips"
  homepage "https://github.com/VisionAdvanceTechnologyInc/vatek_sdk_2"
  url "https://github.com/VisionAdvanceTechnologyInc/vatek_sdk_2/archive/refs/tags/v3.12.1.tar.gz"
  sha256 "293a9d8f271fe960c987b0c620bbc1daacaf1fba00374c3431cab990456ba516"
  license "BSD-2-Clause"
  head "https://github.com/VisionAdvanceTechnologyInc/vatek_sdk_2.git", branch: "main"


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "0090bbbae312276acbe6cf770cb898419c5a49ae492815d9677527f421b75dfa"
  end

  depends_on "cmake" => :build
  depends_on "libusb"

  deny_network_access!
  def install
    system "cmake", "-S", ".", "-B", "builddir",
                    "-DSDK2_EN_QT=OFF", "-DSDK2_EN_APP=OFF", "-DSDK2_EN_SAMPLE=OFF",
                    *std_cmake_args
    system "cmake", "--build", "builddir"
    system "cmake", "--install", "builddir"
  end

  test do
    (testpath/"vatek_test.c").write <<~C
      #include <vatek_sdk_device.h>
      #include <stdio.h>
      #include <stdlib.h>

      int main()
      {
          hvatek_devices hdevices = NULL;
          vatek_result devcount = vatek_device_list_enum(DEVICE_BUS_USB, service_transform, &hdevices);
          if (is_vatek_success(devcount)) {
              printf("passed\\n");
              return EXIT_SUCCESS;
          }
          else {
              printf("failed\\n");
              return EXIT_FAILURE;
          }
      }
    C
    system ENV.cc, "vatek_test.c", "-I#{include}/vatek", "-L#{lib}", "-lvatek_core", "-o", "vatek_test"
    assert_equal "passed", shell_output("./vatek_test").strip
  end
end
