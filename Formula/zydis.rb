class Zydis < Formula
  desc "Fast and lightweight x86/x86_64 disassembler library"
  homepage "https://zydis.re"
  url "https://github.com/zyantific/zydis/archive/refs/tags/v4.1.1.tar.gz"
  sha256 "45c6d4d499a1cc80780f7834747c637509777c01dca1e98c5e7c0bfaccdb1514"
  license "MIT"
  bottle do
    rebuild 2
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "6dfb81121faaa7cc8afd43e1e26f887485c9ad215e06874a59578ee723fe2524"
  end

  head "https://github.com/zyantific/zydis.git", branch: "master"



  depends_on "cmake" => :build
  depends_on "ronn-ng" => :build
  depends_on "zycore-c"

  deny_network_access!

  def install
    args = %W[
      -DCMAKE_INSTALL_RPATH=#{rpath}
      -DZYAN_SYSTEM_ZYCORE=ON
      -DZYDIS_BUILD_MAN=ON
      -DZYDIS_BUILD_SHARED_LIB=ON
      -DZYDIS_BUILD_TESTS=OFF
    ]
    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    (pkgshare/"examples").install "examples/EncodeMov.c"
  end

  test do
    output = shell_output("#{bin}/ZydisInfo -64 66 3E 65 2E F0 F2 F3 48 01 A4 98 2C 01 00 00")
    assert_match "xrelease lock add qword ptr gs:[rax+rbx*4+0x12C], rsp", output

    system ENV.cc, pkgshare/"examples/EncodeMov.c", "-o", "test", "-L#{lib}", "-lZydis"
    assert_equal "48 C7 C0 37 13 00 00", shell_output("./test").strip
  end
end
