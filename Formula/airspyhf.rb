class Airspyhf < Formula
  desc "Driver and tools for a software-defined radio"
  homepage "https://airspy.com/"
  license "BSD-3-Clause"
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "d5b47756bc18fb0d2108a8db36112c81bc35225fc0db1e863062aa5672f3fd45"
  end

  head "https://github.com/airspy/airspyhf.git", branch: "master"

  stable do
    url "https://github.com/airspy/airspyhf/archive/refs/tags/1.6.8.tar.gz"
    sha256 "cd1e5ae89e09b813b096ae4a328e352c9432a582e03fd7da86760ba60efa77ab"

    # CMake 4 build patch, remove in the next release
    # PR ref: https://github.com/airspy/airspyhf/pull/54
    patch do
      url "https://github.com/airspy/airspyhf/commit/e9c483aaa6da6faebc648ba2a065608dc7f3ee08.patch?full_index=1"
      sha256 "06d76fc39f1473c7a09bef1883b68c6bf965b56a1e02c870f5c4d7ea528a78f4"
      type :backport
    end
    patch do
      url "https://github.com/airspy/airspyhf/commit/0aa25232542b2bccab3f94a1f7171d8720709d6d.patch?full_index=1"
      sha256 "850e7e46cc154f12c4a86254e3f8be0d7b5704bef8bb4612819838c0cc99aa86"
      type :backport
    end
    patch do
      url "https://github.com/airspy/airspyhf/commit/0dbb10cd22e2ef1546c8a79d418529bd577acd23.patch?full_index=1"
      sha256 "8736a181e3e6d2cf377f09df2a086ce950c9323e23b9b02dd00685519c30edcc"
      type :backport
    end
  end


  depends_on "cmake" => :build
  depends_on "pkgconf" => :build
  depends_on "libusb"

  deny_network_access!

  def install
    # conf-cc 追加（djb 风格：compile 脚本从 conf-cc 读编译器）
    %w[conf-cc conf-cxx].each do |cf|
      next unless File.exist?(cf)
      _c = File.read(cf).strip
      File.write(cf, _c + " -std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types\n") unless _c.include?("gnu17")
    end
    # cc 命令改写（Makefile 里写死 cc 而非 $(CC) 时）
    Dir["Makefile", "**/Makefile", "**/GNUmakefile", "**/Makefile.*"].each do |mkf|
      next unless File.exist?(mkf)
      _m = File.read(mkf)
      _m = _m.gsub(/^(	| {0,4})(cc|gcc)([ 	])/) { "#{$1}$(CC)#{$3}" }
      File.write(mkf, _m)
    end
    # CMake 标志追加
    _cmflags = ["-DCMAKE_C_FLAGS=-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types", "-DCMAKE_CXX_FLAGS=-std=gnu++17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types"].freeze
    # ENV.cc 追加
    _extra = "-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types".split
    Dir["Makefile", "GNUmakefile", "makefile", "src/Makefile"].each do |mkf|
      next unless File.exist?(mkf)
      _m = File.read(mkf)
      _m = _m.gsub(/-std=(c|gnu)(89|99|11|17|2x)/, "")
      File.write(mkf, _m)
    end
    # Makefile 里面追加（硬编码 CFLAGS 时 ENV 追加不生效）
    Dir["Makefile", "GNUmakefile", "makefile", "**/Makefile", "**/GNUmakefile", "**/makefile", "**/Makefile.*"].each do |mkf|
      next unless File.exist?(mkf)
      _m = File.read(mkf)
      _m = _m.sub(/^(CFLAGS[ \t]*[+:]?=)/) { $1 + " -std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types " }
      File.write(mkf, _m)
    end
    # CFLAGS 里面追加（configure 硬编码时 ENV 追加不生效）
    if File.exist?("configure")
      _cfg = File.read("configure")
      _cfg = _cfg.gsub(/^CFLAGS="([^"\\]*)"/) { 'CFLAGS="' + $1 + ' -std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types"' }
      File.write("configure", _cfg)
    end
    ENV.append_to_cflags "-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types"
    system "cmake", "-S", ".", "-B", "build", *_cmflags, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <libairspyhf/airspyhf.h>

      int main() {
        uint64_t serials[256];
        int n = airspyhf_list_devices(serials, 256);

        if (n == 0){
          return 0;
        }

        return 1;
      }
    C

    system ENV.cc, "test.c", "-o", "test", "-I#{include}", "-L#{lib}", "-lairspyhf", "-lm"
    system "./test"
    assert_match version.to_s, shell_output("#{bin}/airspyhf_lib_version").chomp
  end
end
