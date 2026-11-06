class Wiredtiger < Formula
  desc "High performance NoSQL extensible platform for data management"
  homepage "https://source.wiredtiger.com/"
  url "https://github.com/wiredtiger/wiredtiger/archive/refs/tags/11.3.1.tar.gz"
  sha256 "ac0417c10cecc686baff5fdc00a7872003fc007993163bafba387fad903d5091"
  license any_of: ["GPL-2.0-only", "GPL-3.0-only"]

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end



  bottle do
    rebuild 3
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "ed9cc9961255d7234e86803eccac1167ed086684c89dc80f9c1eb185f2b4d514"
  end

  depends_on "cmake" => :build
  depends_on "lz4"
  depends_on "snappy"
  depends_on "zstd"

  uses_from_macos "python" => :build

  on_linux do
    depends_on "zlib-ng-compat"
  end

  conflicts_with "worktrunk", because: "both install `wt` binaries"

  def install
    # CRC32 hardware detection: https://github.com/wiredtiger/wiredtiger/tree/develop/src/checksum
    ENV.runtime_cpu_detection

    args = %W[
      -DCCACHE_FOUND=CCACHE_FOUND-NOTFOUND
      -DHAVE_BUILTIN_EXTENSION_SNAPPY=1
      -DHAVE_BUILTIN_EXTENSION_ZLIB=1
      -DCMAKE_INSTALL_RPATH=#{rpath}
      -DENABLE_PYTHON=OFF
    ]
    args << "-DCMAKE_C_FLAGS=-Wno-maybe-uninitialized" if OS.linux?
    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    system bin/"wt", "create", "table:test"
    system bin/"wt", "drop", "table:test"
  end
end
