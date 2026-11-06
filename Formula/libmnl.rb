class Libmnl < Formula
  desc "Minimalistic user-space library oriented to Netlink developers"
  homepage "https://www.netfilter.org/projects/libmnl"
  url "https://www.netfilter.org/projects/libmnl/files/libmnl-1.0.5.tar.bz2"
  sha256 "274b9b919ef3152bfb3da3a13c950dd60d6e2bcd54230ffeca298d03b40d0525"
  license "LGPL-2.1-or-later"
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "941d3dddd015033857fb69111ad7cdd7658e31973fc8f30c78a08e2e21d7b6cf"
  end

  compatibility_version 1

  livecheck do
    url "https://www.netfilter.org/projects/libmnl/downloads.html"
    regex(/href=.*?libmnl[._-]v?(\d+(?:\.\d+)+)\.t/i)
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
      #include <stdio.h>
      #include <stdlib.h>
      #include <unistd.h>
      #include <time.h>

      #include <libmnl/libmnl.h>
      #include <linux/netlink.h>

      int main(int argc, char *argv[])
      {
        struct mnl_socket *nl;
        char buf[MNL_SOCKET_BUFFER_SIZE];
      }
    C

    system ENV.cc, "test.c", "-I#{include}", "-L#{lib}", "-lmnl", "-o", "test"
  end
end
