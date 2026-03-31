class Gmp < Formula
  desc "GNU multiple precision arithmetic library"
  homepage "https://gmplib.org/"
  url "https://ftpmirror.gnu.org/gnu/gmp/gmp-6.3.0.tar.xz"
  sha256 "a3c2b80201b89e68616f4ad30bc66aee4927c3ce50e33929ca819d5c43538898"
  license any_of: ["LGPL-3.0-or-later", "GPL-2.0-or-later"]

  def install
    system "cp", "-r", "/usr/include/gmp*", "#{include}/" rescue nil
    system "cp", "/usr/lib/libgmp*", "#{lib}/" rescue nil
    
    if !File.exist?("#{lib}/libgmp.so")
      cpu = Hardware::CPU.loongarch? ? "loongarch64" : Hardware.oldest_cpu
      
      ENV["CFLAGS"] = "-O2 -fpermissive"
      ENV["CXXFLAGS"] = "-O2 -fpermissive"
      ENV["CC"] = "gcc-15"
      ENV["CXX"] = "g++-15"
      
      args = [
        "--prefix=#{prefix}",
        "--libdir=#{lib}",
        "--enable-cxx",
        "--with-pic",
        "--build=#{cpu}-unknown-linux-gnu",
        "--disable-static"
      ]
      
      system "./configure", *args
      system "make"
      system "make", "install"
    end
  end

  test do
    (testpath/"test.c").write <<~C
      #include <gmp.h>
      int main() { mpz_t i; mpz_init(i); return 0; }
    C
    system ENV.cc, "test.c", "-lgmp", "-o", "test"
    system "./test"
  end
end
