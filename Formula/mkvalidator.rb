class Mkvalidator < Formula
  desc "Tool to verify Matroska and WebM files for spec conformance"
  homepage "https://www.matroska.org/downloads/mkvalidator.html"
  url "https://downloads.sourceforge.net/project/matroska/mkvalidator/mkvalidator-0.6.0.tar.bz2"
  sha256 "f9eaa2138fade7103e6df999425291d2947c5355294239874041471e3aa243f0"
  license "BSD-3-Clause"

  livecheck do
    url :stable
    regex(%r{url=.*?/mkvalidator[._-]v?(\d+(?:\.\d+)+)\.t}i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "fa9111b9d84df64f16a406c7abc793b3cdcfff960f54c8dd342e8bf00e557dff"
  end

  depends_on "cmake" => :build

  resource "tests", :test do
    url "https://github.com/dunn/garbage/raw/c0e682836e5237eef42a000e7d00dcd4b6dcebdb/test.mka"
    sha256 "6d7cc62177ec3f88c908614ad54b86dde469dbd2b348761f6512d6fc655ec90c"
  end

  allow_network_access! :test

  def install
    # Workaround for CMake 4 compatibility
    args = %w[-DCMAKE_POLICY_VERSION_MINIMUM=3.5]
    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    bin.install "build/mkvalidator/mkvalidator"
  end

  test do
    resource("tests").stage do
      system bin/"mkvalidator", "test.mka"
    end
  end
end
