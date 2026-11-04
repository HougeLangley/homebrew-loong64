class AmqpCpp < Formula
  desc "C++ library for communicating with a RabbitMQ message broker"
  homepage "https://github.com/CopernicaMarketingSoftware/AMQP-CPP"
  url "https://github.com/CopernicaMarketingSoftware/AMQP-CPP/archive/refs/tags/v4.3.27.tar.gz"
  sha256 "af649ef8b14076325387e0a1d2d16dd8395ff3db75d79cc904eb6c179c1982fe"
  license "Apache-2.0"
  revision 1
  head "https://github.com/CopernicaMarketingSoftware/AMQP-CPP.git", branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "602ae14d3052191b369a9768f74c3f6233b0cda61e085e43ff15b95c635300fa"
  end

  depends_on "cmake" => :build
  depends_on "openssl@4"

  # Fix for CMake 4
  patch do
    url "https://github.com/CopernicaMarketingSoftware/AMQP-CPP/commit/3a80a681ec258807c24f54214a3b6c7fc0dc28c0.patch?full_index=1"
    sha256 "70337b274251cfe890ecf560109d7389e43ae44fb93b43f1279871aa9aa7f139"
    type :unofficial
    resolves "https://github.com/CopernicaMarketingSoftware/AMQP-CPP/pull/541"
  end

  deny_network_access!

  def install
    args = %w[
      -DAMQP-CPP_BUILD_SHARED=ON
      -DAMQP-CPP_LINUX_TCP=ON
      -DCMAKE_MACOSX_RPATH=1
    ]
    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    (testpath/"test.cpp").write <<~CPP
      #include <amqpcpp.h>
      int main()
      {
        return 0;
      }
    CPP
    system ENV.cxx, "test.cpp", "-std=c++17", "-L#{lib}", "-o",
                    "test", "-lamqpcpp"
    system "./test"
  end
end
