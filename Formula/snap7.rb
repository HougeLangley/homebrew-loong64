class Snap7 < Formula
  desc "Ethernet communication suite that works natively with Siemens S7 PLCs"
  homepage "https://snap7.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/snap7/1.4.2/snap7-full-1.4.2.7z"
  sha256 "1f4270cde8684957770a10a1d311c226e670d9589c69841a9012e818f7b9f80e"
  license "LGPL-3.0-or-later"
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "22eda50fe3a489d06f1237177e18dc2819c37b5c1b4694eb7412a807b0545091"
  end

  revision 1



  def install
    lib.mkpath
    os_dir = OS.mac? ? "osx" : "unix"
    os = OS.mac? ? "osx" : OS.kernel_name.downcase
    system "make", "-C", "build/#{os_dir}",
                   "-f", "x86_64_#{os}.mk",
                   "install", "LibInstall=#{lib}"
    include.install "release/Wrappers/c-cpp/snap7.h"
  end

  test do
    (testpath/"test.c").write <<~C
      #include "snap7.h"
      int main()
      {
        S7Object Client = Cli_Create();
        Cli_Destroy(&Client);
        return 0;
      }
    C
    system ENV.cc, "-o", "test", "test.c", "-L#{lib}", "-lsnap7"
    system "./test"
  end
end
