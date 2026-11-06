class Libserialport < Formula
  desc "Cross-platform serial port C library"
  homepage "https://sigrok.org/wiki/Libserialport"
  url "https://sigrok.org/download/source/libserialport/libserialport-0.1.2.tar.gz"
  sha256 "5deb92b5ca72c0347b07b786848350deca2dcfd975ce613b8e0e1d947a4b4ca9"
  license "LGPL-3.0-or-later"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "4ab6849a44c3468da89fb819147c6263d14bab3b84676fb712219ed8ff4b75f7"
  end

  livecheck do
    url "https://sigrok.org/wiki/Downloads"
    regex(/href=.*?libserialport[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  head do
    url "git://sigrok.org/libserialport", branch: "master"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "./autogen.sh" if build.head?
    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--disable-silent-rules", *std_configure_args
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <libserialport.h>
      int main() {
       struct sp_port *list_ptr = NULL;
       sp_get_port_by_name("some port", &list_ptr);
       return 0;
      }
    C
    system ENV.cc, "test.c", "-I#{include}", "-L#{lib}", "-lserialport",
                   "-o", "test"
    system "./test"
  end
end
