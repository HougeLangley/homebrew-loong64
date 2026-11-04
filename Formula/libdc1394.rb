class Libdc1394 < Formula
  desc "Provides API for IEEE 1394 cameras"
  homepage "https://damien.douxchamps.net/ieee1394/libdc1394/"
  url "https://downloads.sourceforge.net/project/libdc1394/libdc1394-2/2.2.7/libdc1394-2.2.7.tar.gz"
  sha256 "537ceb78dd3cef271a183f4a176191d1cecf85f025520e6bd3758b0e19e6609f"
  license "LGPL-2.1-or-later"


  on_linux do
    depends_on "pkgconf" => :build
    depends_on "libusb"
  end

  # fix issue due to bug in OSX Firewire stack
  patch do
    file "Patches/libdc1394/capture.patch"
  end

  # Fix -flat_namespace being used on Big Sur and later.
  patch do
    file "Patches/libtool/configure-pre-0.4.2.418-big_sur.diff"
  end

  bottle do
    rebuild 2
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "e9c9c28b2b8dd2bccaef2871372e37cb268f81d0efbd9327e769cf752af701a8"
  end

  def install
    system "./configure", "--disable-examples",
                          "--disable-sdltest",
                          *std_configure_args
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <dc1394/dc1394.h>

      int main(void) {
        dc1394error_t err;
        dc1394_t * d;
        dc1394camera_list_t * list;

        d = dc1394_new();
        if(!d)
          return 1;

        err = dc1394_camera_enumerate(d, &list);
        DC1394_ERR_RTN(err, "Failed to enumerate cameras");

        dc1394_camera_free_list(list);
        dc1394_free(d);
        return 0;
      }
    C

    system ENV.cc, "test.c", "-o", "test", "-L#{lib}", "-ldc1394"
    system "./test"
  end
end
