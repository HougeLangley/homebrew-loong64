class Snap7 < Formula
  desc "Ethernet communication suite that works natively with Siemens S7 PLCs"
  homepage "https://snap7.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/snap7/1.4.2/snap7-full-1.4.2.7z"
  sha256 "1f4270cde8684957770a10a1d311c226e670d9589c69841a9012e818f7b9f80e"
  license "LGPL-3.0-or-later"
  revision 1


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "0d496f4affecdea1a54aba0115437c8f4234a5ef82aa272efc7c76e8a693a621"
  end

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
    # snap7.h contains `typedef int bool;`, a hard error under GCC 16's
    # default C23 mode (`bool` is a keyword). Compile as C11 like upstream's
    # own examples do.
    system ENV.cc, "-std=c11", "-o", "test", "test.c", "-L#{lib}", "-lsnap7"
    system "./test"
  end
end
