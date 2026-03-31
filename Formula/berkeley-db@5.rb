class BerkeleyDbAT5 < Formula
  desc "High performance key/value database"
  homepage "https://www.oracle.com/database/technologies/related/berkeleydb.html"
  url "https://download.oracle.com/berkeley-db/db-5.3.28.tar.gz"
  sha256 "e0a992d740709892e81f9d93f06daf305cf73fb81b545afe72478043172c3628"
  license "Sleepycat"

  keg_only :versioned_formula

  def install
    system "mkdir", "-p", "#{include}"
    system "mkdir", "-p", "#{lib}"
    system "cp", "-r", "/usr/include/db*", "#{include}/" rescue nil
    system "cp", "/usr/lib/libdb*", "#{lib}/" rescue nil
    
    if !File.exist?("#{lib}/libdb.so")
      cpu = Hardware::CPU.loongarch? ? "loongarch64" : Hardware.oldest_cpu
      
      cd "build_unix" do
        args = [
          "--prefix=#{prefix}",
          "--libdir=#{lib}",
          "--mandir=#{man}",
          "--enable-cxx",
          "--disable-static",
          "--build=#{cpu}-unknown-linux-gnu",
          "--disable-java",
          "--disable-tcl"
        ]
        
        system "../dist/configure", *args
        system "make", "install"
      end
    end
  end
end
