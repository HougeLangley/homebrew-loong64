class Libcuefile < Formula
  desc "Library to work with CUE files"
  homepage "https://www.musepack.net/"
  url "https://files.musepack.net/source/libcuefile_r475.tar.gz"
  version "r475"
  sha256 "b681ca6772b3f64010d24de57361faecf426ee6182f5969fcf29b3f649133fe7"
  license "GPL-2.0-or-later"
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "f7353619264c1d5c068b66033bb17e5ce5ee303bd0b8ff16b13a2f585925a342"
  end

  compatibility_version 1

  livecheck do
    url "https://www.musepack.net/index.php?pg=src"
    regex(/href=.*?libcuefile[._-](r\d+)\.t/i)
  end


  depends_on "cmake" => :build

  # Fix comparison operators for proper range checking.
  patch :DATA

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
    # CFLAGS 里面追加（configure 硬编码时 ENV 追加不生效）
    if File.exist?("configure")
      _cfg = File.read("configure")
      _cfg = _cfg.gsub(/^CFLAGS="([^"]*)"/) { 'CFLAGS="' + $1 + ' -std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types' }
      File.write("configure", _cfg)
    end
    ENV.append_to_cflags "-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types"
    # Fix compile with newer Clang
    ENV.append_to_cflags "-Wno-implicit-function-declaration" if DevelopmentTools.clang_build_version >= 1403
    # Fix build with CMake 4.0+.
    inreplace "CMakeLists.txt",
              "CMAKE_MINIMUM_REQUIRED(VERSION 2.4)",
              "CMAKE_MINIMUM_REQUIRED(VERSION 3.10)"

    system "cmake", "-S", ".", "-B", "build", *_cmflags, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    include.install "include/cuetools/"
  end

  test do
    (testpath/"test.cue").write <<~EOS
      TITLE "Test Album"
      FILE "test.wav" WAVE
        TRACK 01 AUDIO
          INDEX 01 00:00:00
    EOS

    (testpath/"test.c").write <<~C
      #include <stdio.h>
      #include <cuetools/cuefile.h>

      int main(void) {
        int format = UNKNOWN;
        Cd *cd = cf_parse("test.cue", &format);
        if (cd == NULL) return 1;
        printf("%s\\n", cdtext_get(PTI_TITLE, cd_get_cdtext(cd)));
        cd_delete(cd);
        return 0;
      }
    C

    system ENV.cc, *_extra, "test.c", "-I#{include}", "-L#{lib}", "-lcuefile", "-o", "test"
    assert_equal "Test Album", shell_output("./test").strip
  end
end

__END__
diff --git a/src/cd.c b/src/cd.c
index 2686a77..1f4e9b4 100755
--- a/src/cd.c
+++ b/src/cd.c
@@ -173,7 +173,7 @@ int cd_get_ntrack (Cd *cd)

 Track *cd_get_track (Cd *cd, int i)
 {
-	if (0 < i <= cd->ntrack)
+	if (0 < i && i <= cd->ntrack)
 		return cd->track[i - 1];

 	return NULL;
@@ -306,7 +306,7 @@ int track_get_nindex (Track *track)

 long track_get_index (Track *track, int i)
 {
-	if (0 <= i < track->nindex)
+	if (0 <= i && i < track->nindex)
 		return track->index[i];

 	return -1;
