class Libev < Formula
  desc "Asynchronous event library"
  homepage "https://software.schmorp.de/pkg/libev.html"
  url "https://dist.schmorp.de/libev/Attic/libev-4.33.tar.gz"
  mirror "https://fossies.org/linux/misc/libev-4.33.tar.gz"
  sha256 "507eb7b8d1015fbec5b935f34ebed15bf346bed04a11ab82b8eee848c4205aea"
  license any_of: ["BSD-2-Clause", "GPL-2.0-or-later"]
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "bdffa7d8566444fcd5a0d931e085b9489b71878fe042e171b5dcc95f01d051d0"
  end

  compatibility_version 1

  livecheck do
    url "https://dist.schmorp.de/libev/"
    regex(/href=.*?libev[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  # Fix -flat_namespace being used on Big Sur and later.
  patch do
    file "Patches/libtool/configure-big_sur.diff"
  end

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--disable-silent-rules", *std_configure_args
    system "make", "install"

    # Remove compatibility header to prevent conflict with libevent
    (include/"event.h").unlink
  end

  test do
    (testpath/"test.c").write <<~C
      /* Wait for stdin to become readable, then read and echo the first line. */

      #include <stdio.h>
      #include <stdlib.h>
      #include <unistd.h>
      #include <ev.h>

      ev_io stdin_watcher;

      static void stdin_cb (EV_P_ ev_io *watcher, int revents) {
        char *buf;
        size_t nbytes = 255;
        buf = (char *)malloc(nbytes + 1);
        getline(&buf, &nbytes, stdin);
        printf("%s", buf);
        ev_io_stop(EV_A_ watcher);
        ev_break(EV_A_ EVBREAK_ALL);
      }

      int main() {
        ev_io_init(&stdin_watcher, stdin_cb, STDIN_FILENO, EV_READ);
        ev_io_start(EV_DEFAULT, &stdin_watcher);
        ev_run(EV_DEFAULT, 0);
        return 0;
      }
    C
    system ENV.cc, "test.c", "-I#{include}", "-L#{lib}", "-lev", "-o", "test"
    input = "hello, world\n"
    assert_equal input, pipe_output("./test", input, 0)
  end
end
