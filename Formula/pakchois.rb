class Pakchois < Formula
  desc "PKCS #11 wrapper library"
  homepage "https://www.manyfish.co.uk/pakchois/"
  url "https://www.manyfish.co.uk/pakchois/pakchois-0.4.tar.gz"
  sha256 "d73dc5f235fe98e4d1e8c904f40df1cf8af93204769b97dbb7ef7a4b5b958b9a"
  license "GPL-2.0-or-later"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "08a55cf8bfeb7d87213f1f09ee02ddf5f9c8e07422922c16f831e06f286d1499"
  end

  livecheck do
    url :homepage
    regex(/href=.*?pakchois[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    # Fix flat namespace usage
    inreplace "configure", "${wl}-flat_namespace ${wl}-undefined ${wl}suppress", "${wl}-undefined ${wl}dynamic_lookup"

    args = []
    # Help old config scripts identify arm64 linux
    args << "--build=aarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    args << "--build=loongarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arch == :loongarch64

    system "./configure", *args, *std_configure_args
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <pakchois/pakchois.h>
      #include <stdio.h>

      int main(void) {
        pakchois_module_t *mod = NULL;

        // load non-existent module
        ck_rv_t rv = pakchois_module_load(&mod, "nonexistent-module");
        printf("pakchois_module_load returned: %lu\\n", rv);

        if (rv != 0) {
          printf("Module load failed as expected\\n");
        }

        if (mod != NULL) {
          pakchois_module_destroy(mod);
        }

        return 0;
      }
    C

    system ENV.cc, "test.c", "-I#{include}", "-L#{lib}", "-lpakchois", "-o", "test"
    assert_match "Module load failed as expected", shell_output("./test")
  end
end
