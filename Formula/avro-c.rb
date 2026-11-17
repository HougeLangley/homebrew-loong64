class AvroC < Formula
  desc "Data serialization system"
  homepage "https://avro.apache.org/"
  url "https://www.apache.org/dyn/closer.lua?path=avro/avro-1.12.2/c/avro-c-1.12.2.tar.gz"
  mirror "https://archive.apache.org/dist/avro/avro-1.12.2/c/avro-c-1.12.2.tar.gz"
  sha256 "ccc85c5a967ca647fe0961ddeedf286cde00aacf87834d8ca552a0165ae4aa6d"
  license "Apache-2.0"



  depends_on "cmake" => :build
  depends_on "pkgconf" => :build
  depends_on "jansson"
  depends_on "snappy"
  depends_on "xz"

  on_linux do
    depends_on "zlib-ng-compat"
  end

  resource "homebrew-example", :test do
    url "https://raw.githubusercontent.com/apache/avro/88538e9f1d6be236ce69ea2e0bdd6eed352c503e/lang/c/examples/quickstop.c"
    sha256 "8108fda370afb0e7be4e213d4e339bd2aabc1801dcd0b600380d81c09e5ff94f"
  end

  allow_network_access! :test

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
    testpath.install resource("homebrew-example")
    system ENV.cc, "quickstop.c", "-o", "test", "-I#{include}", "-L#{lib}", "-lavro"
    assert_match "Silent |  (555) 123-6422 | 29 |", shell_output("./test")
  end
end
