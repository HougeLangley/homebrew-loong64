class Prover9 < Formula
  desc "Automated theorem prover for first-order and equational logic"
  homepage "https://www.cs.unm.edu/~mccune/prover9/"
  url "https://www.cs.unm.edu/~mccune/prover9/download/LADR-2009-11A.tar.gz"
  version "2009-11A"
  sha256 "c32bed5807000c0b7161c276e50d9ca0af0cb248df2c1affb2f6fc02471b51d0"
  license "GPL-2.0-only"

  livecheck do
    url "https://www.cs.unm.edu/~mccune/prover9/download/"
    regex(/href=.*?LADR[._-]v?(\d+(?:[.-]\d+[A-Z]?)+)\.t/i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "23238bbda643cdfbe158eeb09b6bf6403c8c1c7870138323968d15c1dc7c4401"
  end

  on_linux do
    # Order of parameters passed to gcc matters
    # This patch is needed for Ubuntu 16.04 LTS, which uses
    # --as-needed with ld.  It should no longer
    # be needed on Ubuntu 18.04 LTS.
    patch :DATA
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
    # Workaround for newer Clang
    ENV.append "XFLAGS", "-Wno-implicit-int" if DevelopmentTools.clang_build_version >= 1403

    ENV.deparallelize
    system "make", "CFLAGS=-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types", "CXXFLAGS=-std=gnu++17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types",  "CC=/home/houge/infra/ci/bin/cc-compat",  "CC2=/home/houge/infra/ci/bin/cc-compat",  "CXX=/home/houge/infra/ci/bin/cxx-compat", "all"
    bin.install "bin/prover9", "bin/mace4"
    man1.install Dir["manpages/*.1"]
  end

  test do
    (testpath/"x2.in").write <<~EOS
      formulas(sos).
        e * x = x.
        x' * x = e.
        (x * y) * z = x * (y * z).
        x * x = e.
      end_of_list.
      formulas(goals).
        x * y = y * x.
      end_of_list.
    EOS
    (testpath/"group2.in").write <<~EOS
      assign(iterate_up_to, 12).
      set(verbose).
      formulas(theory).
      all x all y all z ((x * y) * z = x * (y * z)).
      exists e ((all x (e * x = x)) &
                (all x exists y (y * x = e))).
      exists a exists b (a * b != b * a).
      end_of_list.
    EOS

    system bin/"prover9", "-f", testpath/"x2.in"
    system bin/"mace4", "-f", testpath/"group2.in"
  end
end

__END__
diff --git a/provers.src/Makefile b/provers.src/Makefile
index 78c2543..9c91b4e 100644
--- a/provers.src/Makefile
+++ b/provers.src/Makefile
@@ -63,25 +63,25 @@ prover:
	$(MAKE) prover9

 prover9: prover9.o $(OBJECTS)
-	$(CC) $(CFLAGS) -lm -o prover9 prover9.o $(OBJECTS) ../ladr/libladr.a
+	$(CC) $(CFLAGS) -o prover9 prover9.o $(OBJECTS) ../ladr/libladr.a -lm

 fof-prover9: fof-prover9.o $(OBJECTS)
-	$(CC) $(CFLAGS) -lm -o fof-prover9 fof-prover9.o $(OBJECTS) ../ladr/libladr.a
+	$(CC) $(CFLAGS) -o fof-prover9 fof-prover9.o $(OBJECTS) ../ladr/libladr.a -lm

 ladr_to_tptp: ladr_to_tptp.o $(OBJECTS)
-	$(CC) $(CFLAGS) -lm -o ladr_to_tptp ladr_to_tptp.o $(OBJECTS) ../ladr/libladr.a
+	$(CC) $(CFLAGS) -o ladr_to_tptp ladr_to_tptp.o $(OBJECTS) ../ladr/libladr.a -lm

 tptp_to_ladr: tptp_to_ladr.o $(OBJECTS)
-	$(CC) $(CFLAGS) -lm -o tptp_to_ladr tptp_to_ladr.o $(OBJECTS) ../ladr/libladr.a
+	$(CC) $(CFLAGS) -o tptp_to_ladr tptp_to_ladr.o $(OBJECTS) ../ladr/libladr.a -lm

 autosketches4: autosketches4.o $(OBJECTS)
-	$(CC) $(CFLAGS) -lm -o autosketches4 autosketches4.o $(OBJECTS) ../ladr/libladr.a
+	$(CC) $(CFLAGS) -o autosketches4 autosketches4.o $(OBJECTS) ../ladr/libladr.a -lm

 newauto: newauto.o $(OBJECTS)
-	$(CC) $(CFLAGS) -lm -o newauto newauto.o $(OBJECTS) ../ladr/libladr.a
+	$(CC) $(CFLAGS) -o newauto newauto.o $(OBJECTS) ../ladr/libladr.a -lm

 newsax: newsax.o $(OBJECTS)
-	$(CC) $(CFLAGS) -lm -o newsax newsax.o $(OBJECTS) ../ladr/libladr.a
+	$(CC) $(CFLAGS) -o newsax newsax.o $(OBJECTS) ../ladr/libladr.a -lm

 cgrep: cgrep.o $(OBJECTS)
	$(CC) $(CFLAGS) -o cgrep cgrep.o $(OBJECTS) ../ladr/libladr.a
