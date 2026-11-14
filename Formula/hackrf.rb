class Hackrf < Formula
  desc "Low cost software radio platform"
  homepage "https://greatscottgadgets.com/hackrf/"
  url "https://github.com/greatscottgadgets/hackrf/releases/download/v2026.01.3/hackrf-2026.01.3.tar.xz"
  sha256 "d2b76a1115d9b4df648c29efb2f3c8e80009b7cf9a8adf37abbfdba72101b086"
  license "GPL-2.0-or-later"
  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "a5ef256570c632e67dbfdf7a05cc3e53e1ad0cc067c2bdc74b8654ad06b9dcb9"
  end

  head "https://github.com/greatscottgadgets/hackrf.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end



  depends_on "cmake" => :build
  depends_on "pkgconf" => :build
  depends_on "fftw"
  depends_on "libusb"

  deny_network_access!

  def install
    args = %W[
      -DCMAKE_INSTALL_RPATH=#{rpath}
    ]
    if OS.linux?
      args += %W[
        -DUDEV_RULES_GROUP=plugdev
        -DUDEV_RULES_PATH=#{lib}/udev/rules.d
      ]
    end

    system "cmake", "-S", "host", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    pkgshare.install "firmware-bin/"
  end

  test do
    shell_output("#{bin}/hackrf_transfer", 1)
  end
end
