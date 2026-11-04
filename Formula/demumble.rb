class Demumble < Formula
  desc "More powerful symbol demangler (a la c++filt)"
  homepage "https://github.com/nico/demumble"
  url "https://github.com/nico/demumble/archive/refs/tags/v1.3.0.tar.gz"
  sha256 "29501fbd5522820a1672aea0292105b8706899e4e4b283ff51c126f79b3b2c41"
  license "Apache-2.0"
  head "https://github.com/nico/demumble.git", branch: "main"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "28398f6294b40c86af78ea47c15134ed73e698d1f6148c5e2e2f9f4eca1e709f"
  end

  depends_on "cmake" => :build

  deny_network_access!

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"

    # CMakeLists.txt does not contain install rules
    bin.install "build/demumble"
  end

  test do
    mangled = "__imp_?FLAGS_logtostderr@fLB@@3_NA"
    demangled = "__imp_bool fLB::FLAGS_logtostderr"
    assert_equal demangled, pipe_output(bin/"demumble", mangled)
  end
end
