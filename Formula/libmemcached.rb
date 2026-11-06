class Libmemcached < Formula
  desc "C and C++ client library to the memcached server"
  homepage "https://libmemcached.org/"
  url "https://launchpad.net/libmemcached/1.0/1.0.18/+download/libmemcached-1.0.18.tar.gz"
  sha256 "e22c0bb032fde08f53de9ffbc5a128233041d9f33b5de022c0978a2149885f82"
  license "BSD-3-Clause"
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "79d974eb87043c9496b494356a52997111d1947f31853d41abc8e08d944bd56c"
  end

  revision 2


  depends_on "memcached" => :test

  # https://bugs.launchpad.net/libmemcached/+bug/1245562
  patch do
    file "Patches/libmemcached/1.0.18.patch"
  end

  # Fix -flat_namespace being used on Big Sur and later.
  patch do
    file "Patches/libtool/configure-pre-0.4.2.418-big_sur.diff"
  end

  allow_network_access! :test

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <assert.h>
      #include <string.h>

      #include <libmemcached-1.0/memcached.h>

      int main(int argc, char **argv) {
          char conf[50] = "--SERVER=127.0.0.1:";
          strncat(conf, argv[1], 5);
          memcached_st *memc = memcached(conf, strlen(conf));
          assert(memc != NULL);

          // Add a value.
          const char *key = "key";
          const char *val = "val";
          assert(memcached_add(memc, key, strlen(key), val, strlen(val),
                               (time_t)0, (uint32_t)0) == MEMCACHED_SUCCESS);

          // Fetch and check the added value.
          size_t return_val_len;
          uint32_t return_flags;
          memcached_return_t error;
          char *return_val = memcached_get(memc, key, strlen(key),
                                           &return_val_len, &return_flags, &error);
          assert(return_val != NULL);
          assert(error == MEMCACHED_SUCCESS);
          assert(return_val_len == strlen(val));
          assert(strncmp(return_val, val, return_val_len) == 0);
          assert(return_flags == 0);
          free(return_val);

          memcached_free(memc);
      }
    C
    system ENV.cc, "test.c", "-I#{include}", "-L#{lib}", "-lmemcached", "-o", "test"

    memcached = formula_opt_bin("memcached")/"memcached"
    port = free_port
    io = IO.popen("#{memcached} -l 127.0.0.1 -p #{port}")
    sleep 1
    system "./test", port
    Process.kill "TERM", io.pid
  end
end
