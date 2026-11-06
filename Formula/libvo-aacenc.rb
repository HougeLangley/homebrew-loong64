class LibvoAacenc < Formula
  desc "VisualOn AAC encoder library"
  homepage "https://opencore-amr.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/opencore-amr/vo-aacenc/vo-aacenc-0.1.3.tar.gz"
  sha256 "e51a7477a359f18df7c4f82d195dab4e14e7414cbd48cf79cc195fc446850f36"
  license "Apache-2.0"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "55872785d06bdd4426a9a0a6812e978fe41e367c8d628cfbef02a65b37f0c233"
  end

  livecheck do
    url :stable
    regex(%r{url=.*?/vo-aacenc[._-]v?(\d+(?:\.\d+)+)\.t}i)
  end


  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "./configure", "--build=loongarch64-unknown-linux-gnu", *std_configure_args
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <vo-aacenc/cmnMemory.h>

      int main()
      {
        VO_MEM_INFO info; info.Size = 1;
        VO_S32 uid = 0;
        VO_PTR pMem = (VO_PTR)cmnMemAlloc(uid, &info);
        cmnMemFree(uid, pMem);
        return 0;
      }
    C
    system ENV.cc, "test.c", "-L#{lib}", "-lvo-aacenc", "-o", "test"
    system "./test"
  end
end
