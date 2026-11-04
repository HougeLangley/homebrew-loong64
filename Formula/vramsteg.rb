class Vramsteg < Formula
  desc "Add progress bars to command-line applications"
  homepage "https://gothenburgbitfactory.org/vramsteg/"
  url "https://github.com/GothenburgBitFactory/vramsteg/releases/download/v1.1.0/vramsteg-1.1.0.tar.gz"
  sha256 "9cc82eb195e4673d9ee6151373746bd22513033e96411ffc1d250920801f7037"
  license "MIT"
  head "https://github.com/GothenburgBitFactory/vramsteg.git", branch: "develop"

  livecheck do
    url "https://gothenburgbitfactory.org"
    regex(/href=.*?vramsteg[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "99c82714d3cc3305aa65f6617da1aa59f0e71eb4cbe0dd05901c015810f6af17"
  end

  depends_on "cmake" => :build

  deny_network_access!

  def install
    # Workaround for CMake 4 until following commit is in a release:
    # https://github.com/GothenburgBitFactory/vramsteg/commit/b43db620a922b8ee4b8324804aa0fd6150985e03
    if build.stable?
      odie "Remove `-DCMAKE_POLICY_VERSION_MINIMUM=3.5`" if version > "1.1.1"
      args = ["-DCMAKE_POLICY_VERSION_MINIMUM=3.5"]
    end

    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    # Check to see if vramsteg can obtain the current time as epoch
    assert_match(/^\d+$/, shell_output("#{bin}/vramsteg --now"))
  end
end
