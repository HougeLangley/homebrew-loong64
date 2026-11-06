class Libnfnetlink < Formula
  desc "Low-level library for netfilter related communication"
  homepage "https://www.netfilter.org/projects/libnfnetlink"
  url "https://www.netfilter.org/projects/libnfnetlink/files/libnfnetlink-1.0.2.tar.bz2"
  sha256 "b064c7c3d426efb4786e60a8e6859b82ee2f2c5e49ffeea640cfe4fe33cbc376"
  license "LGPL-2.1-or-later"
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "e92f764de933f2033e23d23d2bea7fdad91b835be948b1b5c22b188a97a96b02"
  end

  compatibility_version 1

  livecheck do
    url "https://www.netfilter.org/projects/libnfnetlink/downloads.html"
    regex(/href=.*?libnfnetlink[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  depends_on :linux

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <libnfnetlink/libnfnetlink.h>

      int main() {
        int i = NFNL_BUFFSIZE;
      }
    C

    system ENV.cc, "test.c", "-I#{include}", "-L#{lib}", "-lnfnetlink", "-o", "test"
  end
end
