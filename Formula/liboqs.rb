class Liboqs < Formula
  desc "Library for quantum-safe cryptography"
  homepage "https://openquantumsafe.org/"
  url "https://github.com/open-quantum-safe/liboqs/archive/refs/tags/0.16.0.tar.gz"
  sha256 "162d5b510518ee5f285f82fa1f16402a885176e818bf1b1a4c3c91c9a2f01eae"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end


  bottle do
    rebuild 2
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "9b2638240c2321f0021ea62e1f823ce61006c2daef8642eb7e5ed32a69971349"
  end

  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "ninja" => :build
  depends_on "openssl@4"

  deny_network_access!

  def openssl = "openssl@4"

  def install
    args = %W[
      -DBUILD_SHARED_LIBS=ON
      -DOQS_USE_OPENSSL=ON
      -DOPENSSL_ROOT_DIR=#{formula_opt_prefix(openssl)}
    ]

    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"

    pkgshare.install "tests"
  end

  test do
    cp pkgshare/"tests/example_kem.c", "test.c"
    system ENV.cc, "test.c",
                  "-I#{formula_opt_include(openssl)}", "-I#{include}",
                  "-L#{formula_opt_lib(openssl)}", "-L#{lib}",
                  "-loqs", "-lssl", "-lcrypto", "-o", "test"
    assert_match "operations completed", shell_output("./test")
  end
end
