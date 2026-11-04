class Qdbm < Formula
  desc "Library of routines for managing a database"
  homepage "https://dbmx.net/qdbm/"
  url "https://dbmx.net/qdbm/qdbm-1.8.78.tar.gz"
  sha256 "b466fe730d751e4bfc5900d1f37b0fb955f2826ac456e70012785e012cdcb73e"
  license "LGPL-2.1-or-later"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "8777823222638c43365ac7ce0bcb0960c93a2ffd880e60b64116a6ca3d6b6cf7"
  end

  livecheck do
    url :homepage
    regex(/href=.*?qdbm[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  # Last release on 2007-12-22. Succeeded by tokyo-cabinet -> kyoto-cabinet -> tkrzw
  deprecate! date: "2026-04-18", because: :unmaintained
  disable! date: "2027-04-18", because: :unmaintained

  on_linux do
    depends_on "zlib-ng-compat"
  end

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    args = %W[
      --disable-debug
      --prefix=#{prefix}
      --enable-zlib
      --enable-iconv
    ]

    if OS.mac?
      # Does not want to build on Linux
      args << "--enable-bzip"
    else
      ENV.append "LDFLAGS", "-L#{formula_opt_lib("zlib-ng-compat")}"
    end

    # The hash functions rely on signed integer overflow wrapping, which Clang 21 optimises away
    ENV.append "CPPFLAGS", "-fwrapv"

    # GCC < 13 with -O2 or higher can cause segmentation faults from loop optimisation bug
    if ENV.compiler.to_s.start_with?("gcc") && DevelopmentTools.gcc_version(ENV.compiler) < 13
      ENV.append "CPPFLAGS", "-fno-tree-vrp"
    end

    system "./configure", "--build=loongarch64-unknown-linux-gnu", *args
    if OS.mac?
      system "make", "mac"
      system "make", "install-mac"
    else
      system "make"
      system "make", "install"
    end
  end

  test do
    (testpath/"test.c").write <<~C
      #include <depot.h>
      #include <stdlib.h>
      #include <stdio.h>

      #define NAME     "mike"
      #define NUMBER   "00-12-34-56"
      #define DBNAME   "book"

      int main(void) {
        DEPOT *depot;
        char *val;

        if(!(depot = dpopen(DBNAME, DP_OWRITER | DP_OCREAT, -1))) { return 1; }
        if(!dpput(depot, NAME, -1, NUMBER, -1, DP_DOVER)) { return 1; }
        if(!(val = dpget(depot, NAME, -1, 0, -1, NULL))) { return 1; }

        printf("%s, %s\\n", NAME, val);
        free(val);

        if(!dpclose(depot)) { return 1; }

        return 0;
      }
    C

    system ENV.cc, "test.c", "-I#{include}", "-L#{lib}", "-lqdbm", "-o", "test"
    assert_equal "mike, 00-12-34-56", shell_output("./test").chomp
  end
end
