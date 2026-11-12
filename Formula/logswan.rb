class Logswan < Formula
  desc "Fast Web log analyzer using probabilistic data structures"
  homepage "https://www.logswan.org"
  url "https://github.com/fcambus/logswan/archive/refs/tags/2.1.17.tar.gz"
  sha256 "47e2c80024a1abf4b3423446e65a520a5002e565a5488c14dcba87a80c820a2a"
  license "BSD-2-Clause"



  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "d86fcb5b3a87a62357701fc87890a0037cd22f029e5ddf0c3d17c38083dfc05f"
  end

  depends_on "cmake" => :build
  depends_on "jansson"
  depends_on "libmaxminddb"

  deny_network_access!

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"

    pkgshare.install "examples"
  end

  test do
    assert_match "visits", shell_output("#{bin}/logswan #{pkgshare}/examples/logswan.log")
  end
end
