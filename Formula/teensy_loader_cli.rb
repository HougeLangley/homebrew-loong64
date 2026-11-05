class TeensyLoaderCli < Formula
  desc "Command-line integration for Teensy USB development boards"
  homepage "https://www.pjrc.com/teensy/loader_cli.html"
  url "https://github.com/PaulStoffregen/teensy_loader_cli/archive/refs/tags/2.3.tar.gz"
  sha256 "d9c5357d7e8b99e9a9ae93f5e921c35a133a4a5d399f57eec10f3a606be5d89f"
  license "GPL-3.0-only"
  head "https://github.com/PaulStoffregen/teensy_loader_cli.git", branch: "master"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "0aaf236e0f3991ac561d8a2bd151180c43e33721c5cc35e94523be793b570629"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "16c36bc25668e666c3ac22f0d6f2f6344e22eddd0488fbe8627481b1e0e4ea9a"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "b91358c333152610ecbdb875f7c77eb7e3e5db9a8165ce08fb4932a526dc1330"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:      "31075e6eb9a92d0ddaa3b9505c00fd00c77b057dc817b192c02bb0a3c1bb9cd0"
    sha256 cellar: :any_skip_relocation, arm64_ventura:     "369f2615e61079c280fa552715b8a771d3f620f4b05bc494b45c568b8f647fb0"
    sha256 cellar: :any_skip_relocation, arm64_monterey:    "6a73f7e320626476c5bbf849d59794329cc55414f9e3dca28e4f6ff7f0e74720"
    sha256 cellar: :any_skip_relocation, sonoma:            "0beb513ca87f99ee2a03e3700570bb2e82f7f6905b2921a5a14a31df6e0f12bf"
    sha256 cellar: :any_skip_relocation, ventura:           "1800778350862ed8662bf3183296fb5ba2efc08a5d9dd4531f684639176d02ee"
    sha256 cellar: :any_skip_relocation, monterey:          "1ac5153cfe35bc276fc73c0bb14823f34bd8ae34b408ab81d3140df1db128d03"
    sha256 cellar: :any_skip_relocation, arm64_linux:       "e48cb8f9df797606fcae3289ae2c308f39760ddc4e8c1a2c098e23af48ac5d1e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:      "578d01b193225d1af0f017f21000dc19fa544e15c090af656869c1de14eb7f44"
  end

  on_linux do
    depends_on "libusb-compat"
  end

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
    _cmflags = ["-DCMAKE_C_FLAGS=-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types", "-DCMAKE_CXX_FLAGS=-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types"].freeze
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
    if OS.mac?
      ENV["OS"] = "MACOSX"
      ENV["SDK"] = MacOS.sdk_path || "/"

      # Work around "Error opening HID Manager" by disabling HID Manager check. Port of alswl's fix.
      # Ref: https://github.com/alswl/teensy_loader_cli/commit/9c16bb0add3ba847df5509328ad6bd5bc09d9ecd
      # Ref: https://forum.pjrc.com/threads/36546-teensy_loader_cli-on-OSX-quot-Error-opening-HID-Manager-quot
      inreplace "teensy_loader_cli.c", /ret != kIOReturnSuccess/, "0"
    end

    system "make", "CFLAGS=-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types", "CXXFLAGS=-std=gnu++17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types",  "CC=/home/houge/infra/ci/bin/cc-compat",  "CC2=/home/houge/infra/ci/bin/cc-compat",  "CXX=/home/houge/infra/ci/bin/cxx-compat"
    bin.install "teensy_loader_cli"
  end

  test do
    output = shell_output("#{bin}/teensy_loader_cli 2>&1", 1)
    assert_match "Filename must be specified", output
  end
end
