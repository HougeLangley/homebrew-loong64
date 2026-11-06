class Autossh < Formula
  desc "Automatically restart SSH sessions and tunnels"
  homepage "https://www.harding.motd.ca/autossh/"
  url "https://www.harding.motd.ca/autossh/autossh-1.4g.tgz"
  mirror "https://deb.debian.org/debian/pool/main/a/autossh/autossh_1.4g.orig.tar.gz"
  sha256 "5fc3cee3361ca1615af862364c480593171d0c54ec156de79fc421e31ae21277"
  license "BSD-1-Clause"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "c56d6e6edbefc8ce28c88fc1ef4fd88a2d16a5cdb65c155c110fdd097672059a"
  end

  livecheck do
    url :homepage
    regex(/href=.*?autossh[._-]v?(\d+(?:\.\d+)+[a-z]?)\.t/i)
  end


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

    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--prefix=#{prefix}", "--mandir=#{man}"
    system "make", "install"
    bin.install "rscreen"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/autossh -V")
  end
end


__END__
diff --git a/rscreen b/rscreen
index f0bbced..ce232c3 100755
--- a/rscreen
+++ b/rscreen
@@ -23,4 +23,4 @@ fi
 #AUTOSSH_PATH=/usr/local/bin/ssh
 export AUTOSSH_POLL AUTOSSH_LOGFILE AUTOSSH_DEBUG AUTOSSH_PATH AUTOSSH_GATETIME AUTOSSH_PORT

-autossh -M 20004 -t $1 "screen -e^Zz -D -R"
+autossh -M 20004 -t $1 "screen -D -R"
