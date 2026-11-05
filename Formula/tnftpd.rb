class Tnftpd < Formula
  desc "NetBSD's FTP server"
  homepage "https://cdn.netbsd.org/pub/NetBSD/misc/tnftp/"
  url "https://cdn.netbsd.org/pub/NetBSD/misc/tnftp/tnftpd-20231001.tar.gz"
  mirror "https://www.mirrorservice.org/sites/ftp.netbsd.org/pub/NetBSD/misc/tnftp/tnftpd-20231001.tar.gz"
  sha256 "24a51bd2e5818ddb8c2479df9c8175a78dd8a5ef49ee3ab09f5f39c35069826e"
  license all_of: ["BSD-2-Clause", "BSD-3-Clause", "ISC"]

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "3bf530a1ceab6eaf4f6a8dcd08f4f464e17c2c6eacf27b344b124aa253f8013b"
  end

  livecheck do
    url :homepage
    regex(/href=.*?tnftpd[._-]v?(\d+(?:\.\d+)*)\.t/i)
  end


  uses_from_macos "bison" => :build
  uses_from_macos "libxcrypt"

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--prefix=#{prefix}"
    system "make"

    sbin.install "src/tnftpd" => "ftpd"
    man8.install "src/tnftpd.man" => "ftpd.8"
    man5.install "src/ftpusers.man" => "ftpusers.5"
    man5.install "src/ftpd.conf.man" => "ftpd.conf.5"
    etc.install "examples/ftpd.conf"
    etc.install "examples/ftpusers"
  end

  def caveats
    <<~EOS
      You may need super-user privileges to run this program properly. See the man
      page for more details.
    EOS
  end

  test do
    # running a whole server, connecting, and so forth is a bit clunky and hard
    # to write properly so...
    expected = OS.mac? ? "ftpd: illegal option -- x" : "ftpd: invalid option -- 'x'"
    assert_match expected, shell_output("#{sbin}/ftpd -x 2>&1", 1)
  end
end
