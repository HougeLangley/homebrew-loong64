class Libshout < Formula
  desc "Data and connectivity library for the Icecast server"
  homepage "https://icecast.org/"
  url "https://ftp.osuosl.org/pub/xiph/releases/libshout/libshout-2.4.6.tar.gz"
  mirror "https://mirror.csclub.uwaterloo.ca/xiph/releases/libshout/libshout-2.4.6.tar.gz"
  sha256 "39cbd4f0efdfddc9755d88217e47f8f2d7108fa767f9d58a2ba26a16d8f7c910"
  license "LGPL-2.0-or-later"
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "5ae118a9579f30bcada3745adb1c5cd4a5bf06ca0e9d728d786a630e6c685fea"
  end

  revision 4
  compatibility_version 1

  livecheck do
    url "https://ftp.osuosl.org/pub/xiph/releases/libshout/?C=M&O=D"
    regex(%r{href=(?:["']?|.*?/)libshout[._-]v?(\d+(?:\.\d+)+)\.t}i)
  end


  depends_on "pkgconf" => [:build, :test]
  depends_on "libogg"
  depends_on "libvorbis"
  depends_on "openssl@4"
  depends_on "speex"
  depends_on "theora"

  # Fix -flat_namespace being used on Big Sur and later.
  patch do
    file "Patches/libtool/configure-big_sur.diff"
  end

  deny_network_access!

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    # Fix compile with newer Clang
    ENV.append_to_cflags "-Wno-implicit-function-declaration" if DevelopmentTools.clang_build_version >= 1403

    system "./configure", "--build=loongarch64-unknown-linux-gnu", *std_configure_args
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <stdio.h>
      #include <shout/shout.h>

      int main(void) {
        shout_init();
        shout_t *shout = shout_new();
        if (shout == NULL) return 1;
        if (shout_set_host(shout, "127.0.0.1") != SHOUTERR_SUCCESS) return 1;
        printf("%s %s\\n", shout_version(NULL, NULL, NULL), shout_get_host(shout));
        shout_free(shout);
        shout_shutdown();
        return 0;
      }
    C
    pkgconf_flags = shell_output("pkgconf --cflags --libs shout").chomp.split
    system ENV.cc, "test.c", "-o", "test", *pkgconf_flags
    assert_equal "#{version} 127.0.0.1", shell_output("./test").strip
  end
end
