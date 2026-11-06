class Le < Formula
  desc "Text editor with block and binary operations"
  homepage "https://github.com/lavv17/le"
  url "https://github.com/lavv17/le/releases/download/v1.16.7/le-1.16.7.tar.gz"
  sha256 "1cbe081eba31e693363c9b8a8464af107e4babfd2354a09a17dc315b3605af41"
  license all_of: ["GPL-3.0-or-later", "GPL-2.0-or-later"]

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "5c2040a186ed92ff4a790f52c016cad7180ad77adef9682ea71bd90f4b817d79"
  end

  livecheck do
    url :stable
    strategy :github_latest
  end


  uses_from_macos "ncurses"

  # Backport fix for hex conflict with std::hex
  patch :DATA # part of https://github.com/lavv17/le/commit/f5582ae199e4c4b80d32e4764715d630203b44f6
  patch do
    url "https://github.com/lavv17/le/commit/f5582ae199e4c4b80d32e4764715d630203b44f6.patch?full_index=1"
    sha256 "aa7ce012a03b86a5e3e7724fcd1c4d3cd304a92193510905eb71e614473c66ef"
    type :backport
    resolves "https://github.com/lavv17/le/pull/39"
  end

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    # Configure script makes bad assumptions about curses locations.
    # Future versions allow this to be manually specified:
    # https://github.com/lavv17/le/commit/d921a3cdb3e1a0b50624d17e5efeb5a76d64f29d
    ncurses = OS.mac? ? MacOS.sdk_path/"usr/include" : formula_opt_include("ncurses")
    inreplace "configure", "/usr/local/include/ncurses", ncurses

    ENV.deparallelize
    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    assert_match "Usage", shell_output("#{bin}/le --help", 1)
  end
end

__END__
diff --git a/src/screen.cc b/src/screen.cc
index fcac4e1..0d429f2 100644
--- a/src/screen.cc
+++ b/src/screen.cc
@@ -408,9 +408,9 @@ void  StatusLine()


    if(hex)
-      sprintf(status,"OctOffs:0%-11lo",(unsigned long)(Offset()));
+      snprintf(status,sizeof(status),"OctOffs:0%-11lo",(unsigned long)(Offset()));
    else
-      sprintf(status,"Line=%-5lu Col=%-4lu",
+      snprintf(status,sizeof(status),"Line=%-5lu Col=%-4lu",
 	 (unsigned long)(GetLine()+1),
 	 (unsigned long)(((Text&&Eol())?GetStdCol():GetCol())+1));
