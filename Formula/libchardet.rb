class Libchardet < Formula
  desc "Mozilla's Universal Charset Detector C/C++ API"
  homepage "https://github.com/Joungkyun/libchardet"
  url "https://github.com/Joungkyun/libchardet/releases/download/1.0.6/libchardet-1.0.6.tar.bz2"
  sha256 "8958d5738c8f7af351cc8f718e922c7961fd2f095fc668bff59ae2a531231592"
  license any_of: ["MPL-1.1", "LGPL-2.1-only"]

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "5270b110f976e7cf765e2c344b520386effb66cd12ab9ba2de3196b474e59341"
  end


  depends_on "pkgconf" => :test

  # Fix -flat_namespace being used on Big Sur and later.
  patch do
    file "Patches/libtool/configure-pre-0.4.2.418-big_sur.diff"
    type :unofficial
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
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <assert.h>
      #include <chardet.h>
      #include <string.h>

      int main(void) {
        DetectObj *o;
        char *str = "안녕하세요";

        if ((o = detect_obj_init()) == NULL)
          return 1;

        switch (detect_r(str, strlen(str), &o)) {
          case CHARDET_NULL_OBJECT:
          case CHARDET_OUT_OF_MEMORY:
            return 1;

          default:
            assert(strcmp(o->encoding, "UTF-8") == 0);
            return 0;
        }
      }
    C
    flags = shell_output("#{formula_opt_bin("pkgconf")}/pkgconf --cflags --libs chardet").strip.split
    system ENV.cc, "test.c", "-o", "test", *flags
    system "./test"

    assert_match version.to_s, (lib/"pkgconfig/chardet.pc").read
  end
end
