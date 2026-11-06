class Lzo < Formula
  desc "Real-time data compression library"
  homepage "https://www.oberhumer.com/opensource/lzo/"
  url "https://www.oberhumer.com/opensource/lzo/download/lzo-2.10.tar.gz"
  sha256 "c0f892943208266f9b6543b3ae308fab6284c5c90e627931446fb49b4221a072"
  license "GPL-2.0-or-later"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "314264589ce6337c33cd1d95cdb75c08c6461a7a0216b1fd92ebcb952c3d577c"
  end

  livecheck do
    url "https://www.oberhumer.com/opensource/lzo/download/"
    regex(/href=.*?lzo[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--enable-shared"
    system "make"
    system "make", "check"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <lzo/lzoconf.h>
      #include <stdio.h>

      int main()
      {
        printf("Testing LZO v%s in Homebrew.\\n",
        LZO_VERSION_STRING);
        return 0;
      }
    C
    system ENV.cc, "test.c", "-I#{include}", "-L#{lib}", "-o", "test"
    assert_match "Testing LZO v#{version} in Homebrew.", shell_output("./test")
  end
end
