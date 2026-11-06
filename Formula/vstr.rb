class Vstr < Formula
  desc "C string library"
  homepage "http://www.and.org/vstr/"
  url "https://distfiles.macports.org/vstr/vstr-1.0.15.tar.bz2"
  mirror "http://www.and.org/vstr/1.0.15/vstr-1.0.15.tar.bz2"
  sha256 "d33bcdd48504ddd21c0d53e4c2ac187ff6f0190d04305e5fe32f685cee6db640"
  license "LGPL-2.1-or-later"


  # Last release on 2006-03-06
  deprecate! date: "2026-07-17", because: :unmaintained
  disable! date: "2027-01-17", because: :unmaintained

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "3893a3977fa191b6642efb543adc30056751f8c1a1967779c8a756ec2ca37b5f"
  end

  depends_on "pkgconf" => :build

  # Fix flat namespace usage on macOS.
  patch :DATA

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    ENV.append "CFLAGS", "--std=gnu89"
    ENV["ac_cv_func_stat64"] = "no" if OS.mac? && Hardware::CPU.arm?

    args = ["--mandir=#{man}"]
    # Help old config scripts identify arm64 linux
    args << "--build=aarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    args << "--build=loongarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arch == :loongarch64

    system "./configure", *args, *std_configure_args
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~C
      // based on http://www.and.org/vstr/examples/ex_hello_world.c
      #define VSTR_COMPILE_INCLUDE 1
      #include <vstr.h>
      #include <errno.h>
      #include <err.h>
      #include <unistd.h>

      int main(void) {
        Vstr_base *s1 = NULL;

        if (!vstr_init())
          err(EXIT_FAILURE, "init");

        if (!(s1 = vstr_dup_cstr_buf(NULL, "Hello Homebrew\\n")))
          err(EXIT_FAILURE, "Create string");

        while (s1->len)
          if (!vstr_sc_write_fd(s1, 1, s1->len, STDOUT_FILENO, NULL)) {
            if ((errno != EAGAIN) && (errno != EINTR))
              err(EXIT_FAILURE, "write");
          }

        vstr_free_base(s1);
        vstr_exit();
      }
    C

    system ENV.cc, "test.c", "-L#{lib}", "-lvstr", "-o", "test"
    system "./test"
  end
end

__END__
diff --git a/configure b/configure
index 84b6b1b..ffa2faf 100755
--- a/configure
+++ b/configure
@@ -8313,7 +8313,7 @@ if test -z "$aix_libpath"; then aix_libpath="/usr/lib:/lib"; fi
          ;;
        *) # Darwin 1.3 on
          if test -z ${MACOSX_DEPLOYMENT_TARGET} ; then
-           allow_undefined_flag='${wl}-flat_namespace ${wl}-undefined ${wl}suppress'
+           allow_undefined_flag='${wl}-undefined ${wl}dynamic_lookup'
          else
            case ${MACOSX_DEPLOYMENT_TARGET} in
              10.[012])
