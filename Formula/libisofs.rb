class Libisofs < Formula
  desc "Library to create an ISO-9660 filesystem with various extensions"
  homepage "https://dev.lovelyhq.com/libburnia/libisofs"
  license "GPL-2.0-or-later"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "ffe99df97e149a4cc0ae5f5b13c75a8c814a12d945b3c8259b87e09603597e20"
  end

  stable do
    url "https://files.libburnia-project.org/releases/libisofs-1.5.8.pl02.tar.gz"
    version "1.5.8.pl02"
    sha256 "10bd584d8f00d8091e814902b9f0a3e209f16e938f510fc23ba05f3fa469db5a"

    # Fix -flat_namespace being used on Big Sur and later.
    patch do
      file "Patches/libtool/configure-pre-0.4.2.418-big_sur.diff"
    end
  end

  livecheck do
    url "https://files.libburnia-project.org/releases/"
    regex(/href=.*?libisofs[._-]v?(\d+(?:\.\d+)+(?:[._-]pl\d+)?)\.t/i)
  end


  head do
    url "https://dev.lovelyhq.com/libburnia/libisofs.git", branch: "master"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool"  => :build
  end

  depends_on "libzip"

  on_linux do
    depends_on "acl"
    depends_on "zlib-ng-compat"
  end

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    if build.head?
      # use gnu libtool instead of apple libtool
      inreplace "bootstrap", "libtool", "glibtool"
      # regenerate configure as release uses old version of libtool
      # which causes flat_namespace
      system "./bootstrap"
    end

    system "./configure", "--build=loongarch64-unknown-linux-gnu", *std_configure_args
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <stdint.h>
      #include <libisofs/libisofs.h>

      int main() {
        int major, minor, micro;
        iso_lib_version(&major, &minor, &micro);
        return 0;
      }
    C
    system ENV.cc, "test.c", "-L#{lib}", "-I#{include}", "-lisofs", "-o", "test"
    system "./test"
  end
end
