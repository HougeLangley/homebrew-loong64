class Cgdb < Formula
  desc "Curses-based interface to the GNU Debugger"
  homepage "https://cgdb.github.io/"
  url "https://cgdb.me/files/cgdb-0.8.0.tar.gz"
  sha256 "0d38b524d377257b106bad6d856d8ae3304140e1ee24085343e6ddf1b65811f1"
  license "GPL-2.0-or-later"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "49fe51cb4d2ba683691c9f55ee23cf532793a6b2c6b849b5a5182ce7d010bcee"
  end

  livecheck do
    url "https://cgdb.me/files/"
    regex(/href=.*?cgdb[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  head do
    url "https://github.com/cgdb/cgdb.git", branch: "master"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
  end

  depends_on "help2man" => :build
  depends_on "readline"

  uses_from_macos "flex" => :build
  uses_from_macos "ncurses"

  on_system :linux, macos: :ventura_or_newer do
    depends_on "texinfo" => :build
  end

  # patch for readline check code, upstream pr ref, https://github.com/cgdb/cgdb/pull/359
  patch :DATA

  deny_network_access!

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "sh", "autogen.sh" if build.head?
    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--with-readline=#{formula_opt_prefix("readline")}"
    system "make", "install"
  end

  test do
    system bin/"cgdb", "--version"
  end
end

__END__
diff --git a/configure b/configure
index c564dc1..e13c67c 100755
--- a/configure
+++ b/configure
@@ -6512,7 +6512,7 @@ else
 #include <stdlib.h>
 #include <readline/readline.h>

-main()
+int main()
 {
 	FILE *fp;
 	fp = fopen("conftest.rlv", "w");
