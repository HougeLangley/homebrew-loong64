class Libpcl < Formula
  desc "C library and API for coroutines"
  homepage "http://www.xmailserver.org/libpcl.html"
  url "http://www.xmailserver.org/pcl-1.12.tar.gz"
  sha256 "e7b30546765011575d54ae6b44f9d52f138f5809221270c815d2478273319e1a"
  license "GPL-2.0-or-later"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "f69af4079603b59989473473e840b1a3766896f12e98888c74c067a8e243a5d3"
  end

  livecheck do
    url :homepage
    regex(/href=.*?pcl[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  on_macos do
    depends_on arch: :x86_64

    # Can be undeprecated if upstream decides to support arm64 macOS
    # https://docs.brew.sh/Support-Tiers#future-macos-support
    # TODO: Make linux-only when removing macOS support
    deprecate! date: "2025-09-25", because: :unsupported
    disable! date: "2026-09-25", because: :unsupported
  end

  # Fix -flat_namespace being used on Big Sur and later.
  patch do
    file "Patches/libtool/configure-pre-0.4.2.418-big_sur.diff"
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

    args = []
    args << "--build=aarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    args << "--build=loongarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arch == :loongarch64

    system "./configure", *args, *std_configure_args
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <stdio.h>
      #include <pcl.h>

      static void set_value(void *data) {
        *(int *)data = 42;
        co_exit();
      }

      int main(void) {
        int value = 0;
        coroutine_t co = co_create(set_value, &value, NULL, 32768);
        if (co == NULL) return 1;
        co_call(co);
        printf("%d\\n", value);
        return 0;
      }
    C

    system ENV.cc, "test.c", "-I#{include}", "-L#{lib}", "-lpcl", "-o", "test"
    assert_equal "42", shell_output("./test").strip
  end
end
