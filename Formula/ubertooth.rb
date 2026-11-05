class Ubertooth < Formula
  desc "Host tools for Project Ubertooth"
  homepage "https://greatscottgadgets.com/ubertoothone/"
  url "https://github.com/greatscottgadgets/ubertooth/releases/download/2020-12-R1/ubertooth-2020-12-R1.tar.xz"
  version "2020-12-R1"
  sha256 "93a4ce7af8eddcc299d65aff8dd3a0455293022f7fea4738b286353f833bf986"
  license "GPL-2.0-or-later"
  bottle do
    rebuild 2
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "879cf40fe806c825ce3f393cf8432895c80fd52291d8b56d3a649ac6c83ed579"
  end

  head "https://github.com/greatscottgadgets/ubertooth.git", branch: "master"



  depends_on "cmake" => :build
  depends_on "pkgconf" => :build
  depends_on "libbtbb"
  depends_on "libusb"

  deny_network_access!

  def install
    args = ["-DCMAKE_INSTALL_RPATH=#{rpath}", "-DENABLE_PYTHON=OFF"]
    # Workaround for CMake 4 until fixed upstream, https://github.com/greatscottgadgets/ubertooth/pull/546
    args << "-DCMAKE_POLICY_VERSION_MINIMUM=3.5"
    # Tell CMake to install udev rules in HOMEBREW_PREFIX/etc on Linux because it defaults to /etc.
    args << "-DUDEV_RULES_PATH=#{etc}/udev/rules.d" unless OS.mac?

    system "cmake", "-S", "host", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    # Most ubertooth utilities require an ubertooth device present.
    system bin/"ubertooth-rx", "-i", File::NULL
  end
end
