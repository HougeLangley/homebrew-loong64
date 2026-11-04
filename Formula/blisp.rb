class Blisp < Formula
  desc "ISP tool & library for Bouffalo Labs RISC-V Microcontrollers and SoCs"
  homepage "https://github.com/pine64/blisp"
  url "https://github.com/pine64/blisp/archive/refs/tags/v0.0.5.tar.gz"
  sha256 "79f87fbbb66f1d9ddf250cdc15dc16638d95e0905665003b08920a4b1fda9f96"
  license "MIT"
  revision 1
  head "https://github.com/pine64/blisp.git", branch: "master"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "c2bb84f809ae35242eb8747fb09d5a3d4f0c2038dabdad0142f36f1a4934020e"
  end

  depends_on "cmake" => :build
  depends_on "pkgconf" => :build
  depends_on "argtable3"
  depends_on "libserialport"

  deny_network_access!

  def install
    args = %w[
      -DBLISP_USE_SYSTEM_LIBRARIES=ON
      -DBLISP_BUILD_CLI=ON
    ]

    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"

    # workaround for fixing the header installations,
    # should be fixed with a new release, https://github.com/pine64/blisp/issues/67
    include.install Dir[lib/"blisp*.h"]
  end

  test do
    output = shell_output("#{bin}/blisp write -c bl70x --reset Pinecilv2_EN.bin 2>&1", 11)
    assert_match "Input firmware not found: Pinecilv2_EN.bin", output

    assert_match version.to_s, shell_output("#{bin}/blisp --version")
  end
end
