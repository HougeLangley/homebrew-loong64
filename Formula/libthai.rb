class Libthai < Formula
  desc "Thai language support library"
  homepage "https://linux.thai.net/projects/libthai"
  url "https://linux.thai.net/pub/thailinux/software/libthai/libthai-0.1.30.tar.xz"
  sha256 "ddba8b53dfe584c3253766030218a88825488a51a7deef041d096e715af64bdd"
  license "LGPL-2.1-or-later"
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "7eee84f571ca18ca9409c55b4cfab096d0ed7b720bcf24847fc1017e81b14fcb"
  end

  compatibility_version 1

  livecheck do
    url "https://linux.thai.net/pub/thailinux/software/libthai/"
    regex(/href=["']?libthai[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  depends_on "pkgconf" => [:build, :test]
  depends_on "libdatrie"

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--disable-silent-rules",
                          "--disable-doxygen-doc",
                          *std_configure_args
    system "make"
    system "make", "install"
  end

  test do
    # Basic linkage test to ensure the library is installed and usable
    (testpath/"test.c").write <<~C
      #include <thai/thctype.h>
      #include <stdio.h>

      int main() {
          // 0xa1 is KO KAI in TIS-620 encoding
          if (th_isthai(0xa1)) {
              return 0;
          }
          return 1;
      }
    C
    flags = shell_output("pkgconf --cflags --libs libthai").chomp.split
    system ENV.cc, "test.c", *flags, "-o", "test"
    system "./test"
  end
end
