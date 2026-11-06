class Alpine < Formula
  desc "News and email agent"
  homepage "https://alpineapp.email"
  license "Apache-2.0"
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "2be1048de69f7c07ae9dee19bf36f83a6dbdff287a8070957720a69de32d9a45"
  end

  head "https://repo.or.cz/alpine.git", branch: "master"

  stable do
    url "https://alpineapp.email/alpine/release/src/alpine-2.26.tar.xz"
    # keep mirror even though `brew audit --strict --online` complains
    mirror "https://alpineapp.email/alpine/release/src/Old/alpine-2.26.tar.xz"
    sha256 "c0779c2be6c47d30554854a3e14ef5e36539502b331068851329275898a9baba"

    # patch for macOS obtained from developer; see git commit
    # https://repo.or.cz/alpine.git/commitdiff/701aebc00aff0585ce6c96653714e4ba94834c9c
    # Local copy excludes pith/pine.hlp change due to conflict
    patch do
      file "Patches/alpine/701aebc00aff0585ce6c96653714e4ba94834c9c.diff"
      type :backport
    end

    # fix `error: incompatible function pointer types`
    patch do
      url "https://raw.githubusercontent.com/gentoo/gentoo/37cdeedd76ed2f1f9d169431ac98c9e40afe9372/mail-client/alpine/files/alpine-2.26-fix-clang16-build-no-chappa.patch"
      sha256 "0e51e8253f9e5ff7fc9599845ec2bd3a0007a1bffb097a603dfd8d6fa6362797"
      type :unofficial
    end
  end

  livecheck do
    url :homepage
    regex(/href=.*?alpine[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  depends_on "openssl@3"

  uses_from_macos "krb5"
  uses_from_macos "ncurses"
  uses_from_macos "openldap"

  on_linux do
    depends_on "linux-pam"
  end

  conflicts_with "macpine", because: "both install `alpine` binaries"

  deny_network_access!

  def install
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
      _m = _m.sub(/^(CFLAGS[ \t]*[+:]?=)/) { $1 + " -std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types" }
      File.write(mkf, _m)
    end
    # 老包自带的 config.sub/config.guess 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end
    # CFLAGS 里面追加（configure 硬编码时 ENV 追加不生效）
    if File.exist?("configure")
      _cfg = File.read("configure")
      _cfg = _cfg.gsub(/^CFLAGS="([^"]*)"/) { 'CFLAGS="' + $1 + ' -std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types' }
      File.write("configure", _cfg)
    end
    ENV.append_to_cflags "-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types"
    ENV.deparallelize

    args = %W[
      --with-ssl-dir=#{formula_opt_prefix("openssl@3")}
      --with-ssl-certs-dir=#{etc}/openssl@3
      --with-bundled-tools
    ]

    system "./configure", "--build=loongarch64-unknown-linux-gnu", *args, *std_configure_args
    system "make", "CFLAGS=-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types", "CXXFLAGS=-std=gnu++17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types",  "CC=/home/houge/infra/ci/bin/cc-compat",  "CC2=/home/houge/infra/ci/bin/cc-compat",  "CXX=/home/houge/infra/ci/bin/cxx-compat", "install"
  end

  test do
    system bin/"alpine", "-conf"
  end
end
