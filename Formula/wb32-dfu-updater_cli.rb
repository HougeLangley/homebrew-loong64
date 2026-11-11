class Wb32DfuUpdaterCli < Formula
  desc "USB programmer for downloading and uploading firmware to/from USB devices"
  homepage "https://github.com/WestberryTech/wb32-dfu-updater"
  url "https://github.com/WestberryTech/wb32-dfu-updater/archive/refs/tags/1.0.0.tar.gz"
  sha256 "2b1c5b5627723067168af9740cb25c5c179634e133e4ced06028462096de5699"
  license "Apache-2.0"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "d3abe72b2005613d3bb7829efa6fd02caf7df25afe5ba8de05bd313e401488fb"
  end

  head "https://github.com/WestberryTech/wb32-dfu-updater.git", branch: "master"



  depends_on "cmake" => :build
  depends_on "libusb"

  # Fix compatibility with cmake 4+
  patch do
    url "https://github.com/WestberryTech/wb32-dfu-updater/commit/34725776e4b21be89e5d4eb0ea83346f26fc5d1f.patch?full_index=1"
    sha256 "bfcc362f17c3063b90531e2795e7d33743dc754cce5dac2a93582994f9a88479"
    type :backport
    resolves "https://github.com/WestberryTech/wb32-dfu-updater/pull/17"
  end

  deny_network_access!

  # keg_only: the keg bundles a system libusb shim (see install) that would
  # collide with brew libusb's link in the prefix.
  keg_only "ships a system libusb resolution shim"

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"

    # In the Cellar the relocated RUNPATH's second entry ($ORIGIN/../../../..
    # /lib) resolves to the brew prefix, whose libusb aborts during init on
    # this host (same usbi_mutex_static_lock assert family as owfs). Verified:
    # the same binary run outside the prefix exits 74 correctly with the
    # system libusb. Bundle the SYSTEM library so the first RUNPATH entry
    # always wins; the absolute system path keeps the bottle portable.
    src = "/usr/lib/libusb-1.0.so.0"
    if File.exist?(src)
      lib.mkpath
      FileUtils.ln_sf(src, lib/"libusb-1.0.so.0")
    end
  end

  test do
    assert_match "No DFU capable USB device available\n",
                 shell_output("#{bin}/wb32-dfu-updater_cli -U 111.bin 2>&1", 74)
  end
end
