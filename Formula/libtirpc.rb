class Libtirpc < Formula
  desc "Port of Sun's Transport-Independent RPC library to Linux"
  homepage "https://sourceforge.net/projects/libtirpc/"
  url "https://downloads.sourceforge.net/project/libtirpc/libtirpc/1.3.8/libtirpc-1.3.8.tar.bz2"
  sha256 "8839959bfcc7a0f4c609d8e4f53f1c67ae33de23775ec35beb39ff15adf11920"
  license "BSD-3-Clause"
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "1adef61064c602c0b31870072dbc049bf8d299075a4ca35a692dcbb53ce14423"
  end

  compatibility_version 1


  depends_on "krb5"

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    ENV.append_to_cflags "-D__APPLE_USE_RFC_3542" if OS.mac?
    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--disable-silent-rules", *std_configure_args.reject { |s| s["--disable-debug"] }
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <rpc/rpc.h>
      #include <rpc/xdr.h>
      #include <stdio.h>

      int main() {
        XDR xdr;
        char buf[256];
        xdrmem_create(&xdr, buf, sizeof(buf), XDR_ENCODE);
        int i = 42;
        xdr_destroy(&xdr);
        printf("xdr_int succeeded");
        return 0;
      }
    C
    system ENV.cc, "test.c", "-L#{lib}", "-I#{include}/tirpc", "-ltirpc", "-o", "test"
    system "./test"
  end
end
