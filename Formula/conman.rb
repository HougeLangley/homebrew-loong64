class Conman < Formula
  desc "Serial console management program supporting a large number of devices"
  homepage "https://github.com/dun/conman"
  url "https://github.com/dun/conman/releases/download/conman-0.3.1/conman-0.3.1.tar.xz"
  sha256 "69b449e4a9e992f7e1c6becfb3689be723cefaf94c75226a0bae685df3bc4cb3"
  license "GPL-3.0-or-later"



  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "9d55f963f9592612eb1fc6f5df804d64a00e370f81cd371821b7a6e7fab8c69d"
  end

  depends_on "freeipmi"

  allow_network_access! :test

  def install
    system "./configure", *std_configure_args, "--disable-silent-rules", "--sysconfdir=#{etc}"
    system "make", "install"
    inreplace pkgshare.glob("examples/*.exp"), "/usr/share/", "#{opt_share}/"
  end

  def caveats
    "Before starting the conmand service, configure some consoles in #{etc}/conman.conf."
  end

  service do
    run [opt_sbin/"conmand", "-F", "-c", etc/"conman.conf"]
    keep_alive true
  end

  test do
    assert_match "conman-#{version}", shell_output("#{bin}/conman -V 2>&1")
    assert_match "conman-#{version} FREEIPMI", shell_output("#{sbin}/conmand -V 2>&1")

    conffile = testpath/"conman.conf"
    conffile.write <<~EOS
      console name="test-sleep1" dev="/bin/sleep 30"
      console name="test-sleep2" dev="/bin/sleep 30"
    EOS

    spawn sbin/"conmand", "-F", "-c", conffile
    sleep 5
    assert_match(/test-sleep\d\ntest-sleep\d\n/, shell_output("#{bin}/conman -q 2>&1"))
  end
end
