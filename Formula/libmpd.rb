class Libmpd < Formula
  desc "Higher level access to MPD functions"
  homepage "https://gmpc.fandom.com/wiki/Gnome_Music_Player_Client"
  url "https://www.musicpd.org/download/libmpd/11.8.17/libmpd-11.8.17.tar.gz"
  sha256 "fe20326b0d10641f71c4673fae637bf9222a96e1712f71f170fca2fc34bf7a83"
  license "GPL-2.0-or-later"
  revision 1

  livecheck do
    url "https://www.musicpd.org/download/libmpd/"
    regex(%r{href=["']?v?(\d+(?:\.\d+)+)/?["' >]}i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "46b57eec02ecb86e6dcc4facf13f1a83eda42bbbd07e48f816986ce605bb51d1"
  end

  depends_on "pkgconf" => :build
  depends_on "glib"

  on_macos do
    depends_on "gettext"
  end

  # Fix -flat_namespace being used on Big Sur and later.
  patch do
    file "Patches/libtool/configure-pre-0.4.2.418-big_sur.diff"
  end

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "buildaux/#{cf}", "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}", "dist/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    # GCC 16 treats int-conversion as an error; this legacy source assigns
    # void* through an int-returning prototype. Keep it a warning.
    ENV.append_to_cflags "-std=gnu17 -Wno-error=int-conversion -Wno-error=incompatible-pointer-types"
    # Workaround for newer Clang
    ENV.append_to_cflags "-Wno-int-conversion" if DevelopmentTools.clang_build_version >= 1500

    ENV.append "CFLAGS", "-DHAVE_STRNDUP" unless OS.mac?

    # Help old config scripts identify arm64 linux
    args = ["--build=aarch64-unknown-linux-gnu"] if OS.linux? && Hardware::CPU.arm64?

    system "./configure", "--build=loongarch64-unknown-linux-gnu", *args, *std_configure_args
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <stdio.h>
      #include <stdlib.h>
      #include <libmpd/libmpd.h>

      int main() {
          MpdObj *mpd;
          char *hostname = "localhost";
          int port = 6600;

          mpd = mpd_new(hostname, port, NULL);
          printf("MPD object created");

          mpd_free(mpd);
          return 0;
      }
    C
    system ENV.cc, "test.c", "-o", "test", "-I#{include}/libmpd-1.0", "-L#{lib}", "-lmpd"
    system "./test"
  end
end
