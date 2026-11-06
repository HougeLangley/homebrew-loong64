class Libident < Formula
  desc "Ident protocol library"
  homepage "https://www.remlab.net/libident/"
  url "https://www.remlab.net/files/libident/libident-0.32.tar.gz"
  sha256 "8cc8fb69f1c888be7cffde7f4caeb3dc6cd0abbc475337683a720aa7638a174b"
  license :public_domain

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "7ca8a648af9b1e63cfc412867acfc3e325f9fd372192c3020c3a41ab91f3abde"
  end

  livecheck do
    url "https://www.remlab.net/files/libident/"
    regex(/href=.*?libident[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  deny_network_access!

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    # Run autoreconf to regenerate the configure script and update outdated macros.
    # This ensures that the build system is properly configured on both macOS
    # (avoiding issues like flat namespace conflicts) and Linux (where outdated
    # config scripts may fail to detect the correct build type).
    system "autoreconf", "--force", "--install", "--verbose"

    # C23 makes `()` mean `(void)`, breaking the K&R-style signal handler pointer in id_query.c
    ENV.append_to_cflags "-std=gnu17"

    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--mandir=#{man}", *std_configure_args
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <stdio.h>
      #include <stdlib.h>
      #include <unistd.h>
      #include <ident.h>

      int main(void) {
        int fds[2];
        char buf[64] = {0};
        ident_t *id = calloc(1, sizeof(ident_t));

        if (pipe(fds) != 0) return 1;
        id->fd = fds[1];
        if (id_query(id, 6191, 23, NULL) < 0) return 1;
        if (read(fds[0], buf, sizeof(buf) - 1) <= 0) return 1;
        printf("%s", buf);
        return 0;
      }
    C

    system ENV.cc, "test.c", "-I#{include}", "-L#{lib}", "-lident", "-o", "test"
    assert_equal "6191 , 23\r\n", shell_output("./test")
  end
end
