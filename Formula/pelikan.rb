class Pelikan < Formula
  desc "Production-ready cache services"
  homepage "https://twitter.github.io/pelikan"
  url "https://github.com/twitter/pelikan/archive/refs/tags/0.1.2.tar.gz"
  sha256 "c105fdab8306f10c1dfa660b4e958ff6f381a5099eabcb15013ba42e4635f824"
  license "Apache-2.0"
  head "https://github.com/twitter/pelikan.git", branch: "master"


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "8d5a61b831352625025eae0dfe3a5e7f69a7bd6133f0ffbbd5a869b20eae1331"
  end

  depends_on "cmake" => :build

  deny_network_access!

  def install
    # Work around failure from GCC 10+ using default of `-fno-common`
    # multiple definition of `signals'; ../buffer/cc_buf.c.o:(.bss+0x20): first defined here
    ENV.append_to_cflags "-fcommon" if OS.linux?

    # Workaround to build with CMake 4
    args = %w[-DCMAKE_POLICY_VERSION_MINIMUM=3.5]
    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    system bin/"pelikan_twemcache", "-c"
  end
end
