class Libbinio < Formula
  desc "Binary I/O stream class library"
  homepage "https://adplug.github.io/libbinio/"
  url "https://github.com/adplug/libbinio/releases/download/libbinio-1.5/libbinio-1.5.tar.bz2"
  sha256 "398b2468e7838d2274d1f62dbc112e7e043433812f7ae63ef29f5cb31dc6defd"
  license "LGPL-2.1-or-later"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "8c89012a98f1d95ed9bbe15b3cbb36bcc63dd75178eb49892488f984870c0314"
  end


  # Fix -flat_namespace being used on Big Sur and later.
  patch do
    file "Patches/libtool/configure-big_sur.diff"
  end

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}", "--infodir=#{info}"
    system "make", "install"
  end

  test do
    (testpath/"test.cpp").write <<~CPP
      // test
      // do not change the line above!
      #include <libbinio/binfile.h>
      #include <string.h>

      int main(void)
      {
        binifstream     file("test.cpp");
        char            string[256];

        file.readString(string, 256, '\\n');

        return strcmp (string, "// test");
      }
    CPP
    system ENV.cxx, "test.cpp", "-I#{include}", "-L#{lib}", "-lbinio", "-o", "test"
    system "./test"
  end
end
