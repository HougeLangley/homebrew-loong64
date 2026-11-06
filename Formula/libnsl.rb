class Libnsl < Formula
  desc "Public client interface for NIS(YP) and NIS+"
  homepage "https://github.com/thkukuk/libnsl"
  url "https://github.com/thkukuk/libnsl/releases/download/v2.0.1/libnsl-2.0.1.tar.xz"
  sha256 "5c9e470b232a7acd3433491ac5221b4832f0c71318618dc6aa04dd05ffcd8fd9"
  license "LGPL-2.1-or-later"
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "62858e0ff5822192456f57b063c35d79a341e7af4283b7a2229d6a1e7f01b34d"
  end

  compatibility_version 1


  depends_on "pkgconf" => :build
  depends_on "libtirpc"
  depends_on :linux

  link_overwrite "include/rpcsvc"
  link_overwrite "lib/libnsl.a"
  link_overwrite "lib/libnsl.so"

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "./configure", "--build=loongarch64-unknown-linux-gnu", *std_configure_args,
                          "--disable-silent-rules"
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~'EOS'
      #include <rpcsvc/ypclnt.h>

      int main(int argc, char *argv[]) {
         char *domain;
         switch (yp_get_default_domain(&domain)) {
         case YPERR_SUCCESS:
           printf("Domain: %s\n", domain);
           return 0;
         case YPERR_NODOM:
           printf("No domain\n");
           return 0;
         default:
           return 1;
         }
      }
    EOS

    system ENV.cc, "test.c", "-I#{include}", "-L#{lib}", "-lnsl", "-o", "test"

    domain = Utils.popen_read("ypdomainname").chomp
    domain_exists = $CHILD_STATUS.success?

    output = shell_output("./test").chomp
    if domain_exists
      assert_equal "Domain: #{domain}", output
    else
      assert_equal "No domain", output
    end
  end
end
