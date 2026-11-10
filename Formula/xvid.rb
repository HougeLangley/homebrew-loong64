class Xvid < Formula
  desc "High-performance, high-quality MPEG-4 video library"
  homepage "https://labs.xvid.com/"
  url "https://downloads.xvid.com/downloads/xvidcore-1.3.7.tar.bz2"
  sha256 "aeeaae952d4db395249839a3bd03841d6844843f5a4f84c271ff88f7aa1acff7"
  license "GPL-2.0-or-later"

  livecheck do
    url "https://downloads.xvid.com/downloads/"
    regex(/href=.*?xvidcore[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  # Remove -flat_namespace based on MacPorts patch (which needs autoreconf).
  # https://github.com/macports/macports-ports/blob/master/multimedia/XviD/files/configure-flat_namespace.patch
  # They reported issue via email: https://trac.macports.org/ticket/69855#comment:10
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "9ed76ba794174fac562d3d10621602322b5e96738808560bebb1c496b537a8f3"
  end

  on_macos do
    patch :DATA
  end

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}", "dist/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    cd "build/generic" do
      compat_flags = %w[
        -std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int
        -Wno-error=implicit-function-declaration -Wno-error=int-conversion
        -Wno-error=incompatible-pointer-types
      ]
      cflags = "#{ENV.cflags} #{compat_flags.join(" ")}"
      system "./configure", "--build=loongarch64-unknown-linux-gnu", "--disable-assembly",
             "--prefix=#{prefix}", "CFLAGS=#{cflags}"
      ENV.deparallelize # Work around error: install: mkdir =build: File exists
      system "make"
      system "make", "install"
    end

    # Create unversioned symlink to use shared library
    if OS.mac?
      libxvidcore = shared_library("libxvidcore")
      odie "Remove manual symlink!" if (lib/libxvidcore).exist?
      lib.install_symlink lib.glob(shared_library("libxvidcore", "*")).first => libxvidcore
    end
  end

  test do
    (testpath/"test.cpp").write <<~CPP
      #include <xvid.h>
      #define NULL 0
      int main() {
        xvid_gbl_init_t xvid_gbl_init;
        xvid_global(NULL, XVID_GBL_INIT, &xvid_gbl_init, NULL);
        return 0;
      }
    CPP
    system ENV.cc, "test.cpp", "-L#{lib}", "-lxvidcore", "-o", "test"
    system "./test"
  end
end

__END__
--- a/build/generic/configure
+++ b/build/generic/configure
@@ -4404,7 +4404,7 @@ $as_echo "ok" >&6; }
 	   { $as_echo "$as_me:${as_lineno-$LINENO}: result: dylib options" >&5
 $as_echo "dylib options" >&6; }
 	   SHARED_LIB="libxvidcore.\$(API_MAJOR).\$(SHARED_EXTENSION)"
-	   SPECIFIC_LDFLAGS="-Wl,-read_only_relocs,suppress -dynamiclib -flat_namespace -compatibility_version \$(API_MAJOR) -current_version \$(API_MAJOR).\$(API_MINOR) -install_name \$(libdir)/\$(SHARED_LIB)"
+	   SPECIFIC_LDFLAGS="-Wl,-read_only_relocs,suppress -dynamiclib -compatibility_version \$(API_MAJOR) -current_version \$(API_MAJOR).\$(API_MINOR) -install_name \$(libdir)/\$(SHARED_LIB)"
 	else
 	   { $as_echo "$as_me:${as_lineno-$LINENO}: result: module options" >&5
 $as_echo "module options" >&6; }
