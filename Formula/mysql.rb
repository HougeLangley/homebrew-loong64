class Mysql < Formula
  desc "Open source relational database management system"
  homepage "https://dev.mysql.com/doc/refman/9.2/en/"
  url "https://cdn.mysql.com/Downloads/MySQL-9.2/mysql-9.2.0.tar.gz"
  sha256 "a39b9fa00c9b366a3807a719caa5cb2eb5ccdea04ac017e9d9f16e427d164262"
  license "GPL-2.0-only" => { with: "Universal-FOSS-exception-1.0" }

  depends_on "bison" => :build
  depends_on "cmake" => :build
  depends_on "pkgconf" => :build
  depends_on "icu4c"
  depends_on "libevent"
  depends_on "libfido2"
  depends_on "lz4"
  depends_on "openssl@3"
  depends_on "protobuf"
  depends_on "zlib-ng-compat"
  depends_on "zstd"

  uses_from_macos "curl"
  uses_from_macos "cyrus-sasl"
  uses_from_macos "libedit"

  def install
    cpu = Hardware::CPU.loongarch? ? "loongarch64" : Hardware.oldest_cpu
    
    cmake_args = %W[
      -DFORCE_UNSUPPORTED_COMPILER=1
      -DCMAKE_INSTALL_PREFIX=#{prefix}
      -DMYSQL_DATADIR=#{var}/mysql
      -DSYSCONFDIR=#{etc}
      -DWITH_SSL=yes
      -DWITH_ZLIB=system
      -DWITH_EDITLINE=system
      -DWITH_ICU=system
      -DWITH_LZ4=system
      -DWITH_ZSTD=system
      -DWITH_PROTOBUF=system
      -DENABLED_LOCAL_INFILE=1
      -DWITH_EMBEDDED_SERVER=no
      -DWITH_UNIT_TESTS=OFF
      -DCMAKE_SYSTEM_PROCESSOR=#{cpu}
    ]

    system "cmake", "-S", ".", "-B", "build", *cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    system bin/"mysqld", "--version"
  end
end
