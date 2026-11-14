class Classads < Formula
  desc "Classified Advertisements (used by HTCondor Central Manager)"
  homepage "https://research.cs.wisc.edu/htcondor/classad/"
  url "https://ftp.cs.wisc.edu/condor/classad/c++/classads-1.0.10.tar.gz"
  sha256 "cde2fe23962abb6bc99d8fc5a5cbf88f87e449b63c6bca991d783afb4691efb3"
  license "Apache-2.0"

  livecheck do
    url :homepage
    regex(/href=.*?classads[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "46c02211b4fbac39e1ceff36d3c8f40ac92719a504822aa17e8491604a473340"
  end

  on_macos do
    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  # Allow compilation on ARM, where finite() is not available.
  # Different fix upstream: https://github.com/htcondor/htcondor/commit/ae841558fcffa4cad12f019975292ad27b917f47
  patch :DATA

  deny_network_access!

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "buildaux/#{cf}", "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}", "dist/#{cf}"].each do |rel|
        src = "/usr/share/libtool/build-aux/#{cf}"
        dest = buildpath/rel
        if dest.exist? && File.exist?(src)
          File.chmod(0644, dest)
          cp src, dest
        end
      end
    end

    args = ["--enable-namespace", "--without-pcre"]
    # Help old config scripts identify arm64 linux
    args << "--build=aarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    args << "--build=loongarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arch == :loongarch64

    # Run autoreconf on macOS to rebuild configure script so that it doesn't try
    # to build with a flat namespace.
    system "autoreconf", "--force", "--verbose", "--install" if OS.mac?
    system "./configure", *args, *std_configure_args
    system "make", "install"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/classad_version")
  end
end

__END__
diff -pur classads-1.0.10/util.cpp classads-1.0.10-new/util.cpp
--- classads-1.0.10/util.cpp	2011-04-09 01:36:36
+++ classads-1.0.10-new/util.cpp	2022-11-10 11:16:47
@@ -430,7 +430,7 @@ int classad_isinf(double x) 
 #endif
 int classad_isinf(double x) 
 { 
-    if (finite(x) || x != x) {
+    if (isfinite(x) || x != x) {
         return 0;
     } else if (x > 0) {
         return 1;
