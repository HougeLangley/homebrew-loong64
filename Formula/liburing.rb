class Liburing < Formula
  desc "Helpers to setup and teardown io_uring instances"
  homepage "https://github.com/axboe/liburing"
  # not need to check github releases, as tags are sufficient, see https://github.com/axboe/liburing/issues/1008
  url "https://github.com/axboe/liburing/archive/refs/tags/liburing-2.15.tar.gz"
  sha256 "8d052f2622dcb3678cbaee5ff582a87572672a6c0a56533cdda5b65cb636120a"
  license any_of: ["MIT", "LGPL-2.1-only"]
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "28163d3823503d95985c0f18973524d9b3cc4bf49b2b6589ab622b756a50bf0d"
  end

  head "https://github.com/axboe/liburing.git", branch: "master"


  depends_on :linux

  def install
    # not autotools based configure, so std_configure_args is not suitable
    system "./configure", "--prefix=#{prefix}", "--libdir=#{lib}", "--mandir=#{man}"
    system "make"
    system "make", "install"
  end

  test do
    # CI often denies io_uring with EPERM, but the native RT kernel allows it.
    # Exercise and clean up a real ring when permitted; accept only EPERM otherwise.
    (testpath/"test.c").write <<~C
      #include <errno.h>
      #include <liburing.h>
      #include <stdio.h>
      #include <string.h>

      int main() {
        struct io_uring ring;

        int ret = io_uring_queue_init(1, &ring, 0);
        if (ret == -EPERM) {
          puts("queue_init: Operation not permitted");
          return 0;
        }
        if (ret < 0) {
          fprintf(stderr, "queue_init: %s\\n", strerror(-ret));
          return 1;
        }

        io_uring_queue_exit(&ring);
        puts("queue_init: success");
        return 0;
      }
    C
    system ENV.cc, "test.c", "-L#{opt_lib}", "-luring", "-o", "test"
    assert_match(/queue_init: (?:success|Operation not permitted)/, shell_output("./test 2>&1"))
  end
end
