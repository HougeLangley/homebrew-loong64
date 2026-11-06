class CyrusSasl < Formula
  desc "Simple Authentication and Security Layer"
  homepage "https://www.cyrusimap.org/sasl/"
  url "https://github.com/cyrusimap/cyrus-sasl/releases/download/cyrus-sasl-2.1.28/cyrus-sasl-2.1.28.tar.gz"
  mirror "http://fresh-center.net/linux/misc/cyrus-sasl-2.1.28.tar.gz"
  sha256 "7ccfc6abd01ed67c1a0924b353e526f1b766b21f42d4562ee635a8ebfc5bb38c"
  license "BSD-3-Clause-Attribution"
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "2da7a5b69590f2e050f7782557ac5a3a31cb7a5b146f6314450f3d6a5162156c"
  end

  revision 4


  head do
    url "https://github.com/cyrusimap/cyrus-sasl.git", branch: "master"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  keg_only :provided_by_macos

  depends_on "krb5"
  depends_on "openssl@4"

  uses_from_macos "libxcrypt"

  deny_network_access!

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    # Workaround for missing time.h. Fixed upstream but backport would require autotools deps
    # https://github.com/cyrusimap/cyrus-sasl/commit/266f0acf7f5e029afbb3e263437039e50cd6c262
    # Also force C standard on newer GCC to avoid build failures
    if build.stable?
      odie "Remove workarounds!" if version > "2.1.28"
      ENV.append_to_cflags "-include time.h"
      if ENV.compiler.to_s.start_with?("gcc") && DevelopmentTools.gcc_version(ENV.compiler) >= 15
        ENV.append "CFLAGS", "-std=gnu17"
      end
    end

    args = %w[
      --disable-macos-framework
      --disable-sample
      --disable-silent-rules
    ]

    configure = build.head? ? "./autogen.sh" : "./configure"
    args << "--build=loongarch64-unknown-linux-gnu"
    system configure, *args, *std_configure_args
    system "make", "install"
  end

  test do
    (testpath/"test.cpp").write <<~CPP
      #include <sasl/saslutil.h>
      #include <assert.h>
      #include <stdio.h>
      int main(void) {
        char buf[123] = "\\0";
        unsigned len = 0;
        int ret = sasl_encode64("Hello, world!", 13, buf, sizeof buf, &len);
        assert(ret == SASL_OK);
        printf("%u %s", len, buf);
        return 0;
      }
    CPP

    system ENV.cxx, "-o", "test", "test.cpp", "-I#{include}", "-L#{lib}", "-lsasl2"
    assert_equal "20 SGVsbG8sIHdvcmxkIQ==", shell_output("./test")
  end
end
