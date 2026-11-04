class Geographiclib < Formula
  desc "C++ geography library"
  homepage "https://geographiclib.sourceforge.io/"
  url "https://github.com/geographiclib/geographiclib/archive/refs/tags/r2.7.tar.gz"
  sha256 "5aaca14cd75f13aa2690273d76e88e8ddf4aeb267d6be2c3e0ba948deb9ceea5"
  license "MIT"
  head "https://github.com/geographiclib/geographiclib.git", branch: "main"

  livecheck do
    url :stable
    regex(/^r(\d+(?:\.\d+)+)$/i)
  end


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "04031e74259fd348f2d203078b8969f896ae44233a4d81de01deaaf632a05afb"
  end

  depends_on "cmake" => :build

  deny_network_access!

  def install
    args = ["-DEXAMPLEDIR="]
    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    system bin/"GeoConvert", "-p", "-3", "-m", "--input-string", "33.3 44.4"
  end
end
