class Mpfi < Formula
  desc "Multiple precision interval arithmetic library"
  homepage "https://perso.ens-lyon.fr/nathalie.revol/software.html"
  url "https://perso.ens-lyon.fr/nathalie.revol/softwares/mpfi-1.5.4.tar.bz2"
  sha256 "d20ba56a8d57d0816f028be8b18a4aa909a068efcb9a260e69577939e4199752"
  license all_of: ["GPL-3.0-or-later", "LGPL-2.1-or-later"]

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "0d4cf893e8e0c865310ce46c6591bf9a6839b317f52eb734595af1b6bcf439a8"
  end

  livecheck do
    url :homepage
    regex(/href=.*?mpfi[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  depends_on "gmp"
  depends_on "mpfr"

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--disable-dependency-tracking", "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <mpfi.h>

      int main()
      {
        mpfi_t x;
        mpfi_init(x);
        mpfi_clear(x);
        return 0;
      }
    C

    system ENV.cc, "test.c", "-o", "test",
                   "-L#{lib}", "-lmpfi",
                   "-L#{Formula["mpfr"].lib}", "-lmpfr",
                   "-L#{Formula["gmp"].lib}", "-lgmp"
    system "./test"
  end
end
