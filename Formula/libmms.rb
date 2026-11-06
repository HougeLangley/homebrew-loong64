class Libmms < Formula
  desc "Library for parsing mms:// and mmsh:// network streams"
  homepage "https://sourceforge.net/projects/libmms/"
  url "https://downloads.sourceforge.net/project/libmms/libmms/0.6.4/libmms-0.6.4.tar.gz"
  sha256 "3c05e05aebcbfcc044d9e8c2d4646cd8359be39a3f0ba8ce4e72a9094bee704f"
  license "LGPL-2.1-or-later"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "da5c03ec8221083c0edd8c556b78605818fb4e2809e39d7de9a89e99570a5c12"
  end


  depends_on "pkgconf" => [:build, :test]
  depends_on "glib"

  deny_network_access!

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    ENV.append "LDFLAGS", "-liconv" if OS.mac?
    system "./configure", "--build=loongarch64-unknown-linux-gnu", *std_configure_args
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <stdio.h>
      #include <libmms/mms.h>

      static int fake_connect(void *data, const char *host, int port) {
        printf("%s:%d\\n", host, port);
        return -1;
      }

      int main(void) {
        mms_io_t io = *mms_get_default_io_impl();
        io.connect = fake_connect;
        return mms_connect(&io, NULL, "mms://media.example.com/live.asf", 128000) == NULL ? 0 : 1;
      }
    C

    pkgconf_flags = shell_output("pkgconf --cflags --libs libmms").chomp.split
    system ENV.cc, "test.c", "-o", "test", *pkgconf_flags
    assert_equal "media.example.com:1755", shell_output("./test").strip
  end
end
