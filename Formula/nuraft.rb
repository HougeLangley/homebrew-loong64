class Nuraft < Formula
  desc "C++ implementation of Raft core logic as a replication library"
  homepage "https://github.com/eBay/NuRaft"
  url "https://github.com/eBay/NuRaft/archive/refs/tags/v3.0.0.tar.gz"
  sha256 "073c3b321efec9ce6b2bc487c283e493a1b2dd41082c5e9ac0b8f00f9b73832d"
  license "Apache-2.0"
  revision 1


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "e192d1a8e205f1908f5db62b9d0b3c1400afd3ab79213f1a3e3678e55ca41f18"
  end

  depends_on "cmake" => :build

  depends_on "asio"
  depends_on "openssl@4"

  on_linux do
    depends_on "zlib-ng-compat"
  end

  allow_network_access! :test

  def install
    # Avoid statically linking to OpenSSL
    inreplace "CMakeLists.txt", "set(OPENSSL_USE_STATIC_LIBS TRUE)", ""

    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    pkgshare.install "examples"
  end

  test do
    cp_r pkgshare/"examples/.", testpath
    system ENV.cxx, "-std=c++11", "-o", "test",
                    "quick_start.cxx", "logger.cc", "in_memory_log_store.cxx",
                    "-I#{include}/libnuraft", "-I#{testpath}/echo",
                    "-I#{formula_opt_include("openssl@4")}",
                    "-L#{lib}", "-lnuraft",
                    "-L#{formula_opt_lib("openssl@4")}", "-lcrypto", "-lssl"
    assert_match "hello world", shell_output("./test")
  end
end
