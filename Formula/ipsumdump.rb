class Ipsumdump < Formula
  desc "Summarizes TCP/IP dump files into a self-describing ASCII format"
  homepage "https://read.seas.harvard.edu/~kohler/ipsumdump/"
  url "https://read.seas.harvard.edu/~kohler/ipsumdump/ipsumdump-1.86.tar.gz"
  sha256 "e114cd01b04238b42cd1d0dc6cfb8086a6b0a50672a866f3d0d1888d565e3b9c"
  license "MIT"
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "be5282c9cfa03963727865b092a593e7e089787e4ed555129943d19a0be81e82"
  end

  head "https://github.com/kohler/ipsumdump.git", branch: "master"

  livecheck do
    url :homepage
    regex(/href=.*?ipsumdump[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  # add missing definition for SIOCGSTAMP to support linux arm build
  patch :DATA

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    args = []
    # Help old config scripts identify arm64 linux
    args << "--build=aarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    args << "--build=loongarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arch == :loongarch64

    system "./configure", *args, *std_configure_args
    system "make", "install"
  end

  test do
    output = shell_output("#{bin}/ipsumdump -c -r #{test_fixtures("test.pcap")}")
    assert_match "!host #{Socket.gethostname}", output
    assert_match "!data count\n" + ("1\n" * 12), output
  end
end

__END__
diff --git a/src/fromdevice.cc b/src/fromdevice.cc
index 76e2b12..f59d7bd 100644
--- a/src/fromdevice.cc
+++ b/src/fromdevice.cc
@@ -28,6 +28,11 @@
 #else
 # include <sys/ioccom.h>
 #endif
+
+#ifndef SIOCGSTAMP
+#define SIOCGSTAMP 0x8906
+#endif
+
 #if HAVE_NET_BPF_H
 # include <net/bpf.h>
 # define PCAP_DONT_INCLUDE_PCAP_BPF_H 1
