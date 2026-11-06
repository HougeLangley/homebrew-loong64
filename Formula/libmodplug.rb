class Libmodplug < Formula
  desc "Library from the Modplug-XMMS project"
  homepage "https://modplug-xmms.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/modplug-xmms/libmodplug/0.8.9.0/libmodplug-0.8.9.0.tar.gz"
  sha256 "457ca5a6c179656d66c01505c0d95fafaead4329b9dbaa0f997d00a3508ad9de"
  license :public_domain
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "959da45797b14ab2ab157bf7ed61b091e32a3295023aeb65b377b79167115375"
  end

  compatibility_version 1

  livecheck do
    url :stable
    regex(%r{url=.*?/libmodplug[._-]v?(\d+(?:\.\d+)+)\.t}i)
  end


  resource "testmod", :test do
    # Most favourited song on modarchive:
    # https://modarchive.org/index.php?request=view_by_moduleid&query=212083
    url "https://api.modarchive.org/downloads.php?moduleid=212083#2nd_pm.s3m"
    sha256 "b869c3e70c66010eda066452791cc3f1536bd3ad0bc01b98924c79765b03ceb2"
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

    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--enable-static",
                          "--prefix=#{prefix}"

    system "make", "install"
  end

  test do
    # First a basic test just that we can link on the library
    # and call an initialization method.
    (testpath/"test_null.cpp").write <<~CPP
      #include "libmodplug/modplug.h"
      int main() {
        ModPlugFile* f = ModPlug_Load((void*)0, 0);
        if (!f) {
          // Expecting a null pointer, as no data supplied.
          return 0;
        } else {
          return -1;
        }
      }
    CPP
    system ENV.cc, "test_null.cpp", "-L#{lib}", "-lmodplug", "-o", "test_null"
    system "./test_null"

    # Second, acquire an actual music file from a popular internet
    # source and attempt to parse it.
    resource("testmod").stage testpath
    (testpath/"test_mod.cpp").write <<~CPP
      #include "libmodplug/modplug.h"
      #include <fstream>
      #include <sstream>

      int main() {
        std::ifstream in("2nd_pm.s3m");
        std::stringstream buffer;
        buffer << in.rdbuf();
        int length = buffer.tellp();
        ModPlugFile* f = ModPlug_Load(buffer.str().c_str(), length);
        if (f) {
          // Expecting success
          return 0;
        } else {
          return -1;
        }
      }
    CPP
    system ENV.cxx, "test_mod.cpp", "-L#{lib}", "-lmodplug", "-o", "test_mod"
    system "./test_mod"
  end
end
