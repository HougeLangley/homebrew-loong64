class Airspy < Formula
  desc "Driver and tools for a software-defined radio"
  homepage "https://airspy.com/"
  url "https://github.com/airspy/airspyone_host/archive/refs/tags/v1.0.10.tar.gz"
  sha256 "fcca23911c9a9da71cebeffeba708c59d1d6401eec6eb2dd73cae35b8ea3c613"
  license "GPL-2.0-or-later"

  livecheck do
    skip "cannot update due to non-FOSS terms in newer code"
  end


  # libairspy/src/iqconverter_* files were modified to a non-FOSS license.
  # https://github.com/airspy/airspyone_host/blob/master/libairspy/src/iqconverter_float.c#L10-L12
  #
  # > Any redistribution, publication, sublicensing, or commercial use outside the
  # > Airspy ecosystem is strictly prohibited without prior written consent from the
  # > copyright holders.
  #
  # This has been pointed out by one of the main authors:
  # * https://github.com/airspy/airspyone_host/pull/103#issuecomment-3359538126
  #
  # Fedora thread also agrees this is non-free:
  # * https://lists.fedoraproject.org/archives/list/devel@lists.fedoraproject.org/thread/ZODYXEUOUNFYAYKQKRKK2RTIHEVVGMPN/
  #
  # Can be undeprecated if upstream switches to a FOSS license.
  deprecate! date: "2026-05-30", because: "has code relicensed to non-FOSS after 1.0.10"
  disable! date: "2027-05-30", because: "has code relicensed to non-FOSS after 1.0.10"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "44a7a751ffdd41d43dcaf2a5d0b24e80d48f1a33acb0cfab7d45752c0a465a95"
  end

  depends_on "cmake" => :build
  depends_on "pkgconf" => :build
  depends_on "libusb"

  # CMake 4 build patch, remove in the next release
  patch do
    url "https://github.com/airspy/airspyone_host/commit/7290309a663ced66e1e51dc65c1604e563752310.patch?full_index=1"
    sha256 "982559d6b900aa9aa2de546197153aae4e0de7b852d0cf4404a92ec3c5f00d11"
    type :backport
    resolves "https://github.com/airspy/airspyone_host/pull/80"
  end
  patch do
    url "https://github.com/airspy/airspyone_host/commit/3cf6f97976611c2ff6363f7927fe76c465995801.patch?full_index=1"
    sha256 "0d78db431a2c11622200655cbd446cae3543c333eb6fa2fa1a0909b6d72d24e2"
    type :backport
  end
  patch do
    url "https://github.com/airspy/airspyone_host/commit/f467acd587617640741ecbfade819d10ecd032c2.patch?full_index=1"
    sha256 "5b7cc28179b55245caf379b002ed54eb52ee48b66cc8814b6740bc3d94dc48cf"
    type :backport
    resolves "https://github.com/airspy/airspyone_host/pull/103"
  end

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
      #include <stdio.h>
      #include <libairspy/airspy.h>

      int main() {
        airspy_lib_version_t lib_version;
        airspy_lib_version(&lib_version);

        printf("Airspy library version: %d.%d.%d\\n",
               lib_version.major_version,
               lib_version.minor_version,
               lib_version.revision);

        return 0;
      }
    C

    system ENV.cc, "test.c", "-L#{lib}", "-lairspy", "-o", "test"
    assert_match version.to_s, shell_output("./test")

    assert_match version.to_s, shell_output("#{bin}/airspy_lib_version --version")
  end
end
