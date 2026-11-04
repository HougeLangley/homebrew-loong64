class Mkclean < Formula
  desc "Optimizes Matroska and WebM files"
  homepage "https://www.matroska.org/downloads/mkclean.html"
  url "https://downloads.sourceforge.net/project/matroska/mkclean/mkclean-0.9.0.tar.bz2"
  sha256 "2f5cdcab0e09b65f9fef8949a55ef00ee3dd700e4b4050e245d442347d7cc3db"
  license "BSD-3-Clause"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "6caa1291d08239b911bf6c4cd39a99d13fbeca769f62e0389afda0d54506f921"
  end

  depends_on "cmake" => :build

  deny_network_access!

  def install
    # Workaround for CMake 4 compatibility
    args = %w[-DCMAKE_POLICY_VERSION_MINIMUM=3.5]
    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    bin.install "build/mkclean/mkclean"
  end

  test do
    output = shell_output("#{bin}/mkclean --version 2>&1", 255)
    assert_match version.to_s, output

    output = shell_output("#{bin}/mkclean --keep-cues brew 2>&1", 254)
    assert_match "Could not open file \"brew\" for reading", output
  end
end
