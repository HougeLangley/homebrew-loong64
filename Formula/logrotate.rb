class Logrotate < Formula
  desc "Rotates, compresses, and mails system logs"
  homepage "https://github.com/logrotate/logrotate"
  url "https://github.com/logrotate/logrotate/releases/download/3.22.0/logrotate-3.22.0.tar.xz"
  sha256 "42b4080ee99c9fb6a7d12d8e787637d057a635194e25971997eebbe8d5e57618"
  license "GPL-2.0-or-later"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "ed45e3ae928eefa845ba40abcb64a328de12d66b76c2c9b6d14421c86e0f3f5e"
  end


  depends_on "popt"

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--with-compress-command=/usr/bin/gzip",
                          "--with-uncompress-command=/usr/bin/gunzip",
                          "--with-state-file-path=#{var}/lib/logrotate.status",
                          *std_configure_args
    system "make", "install"

    inreplace "examples/logrotate.conf", "/etc/logrotate.d", "#{etc}/logrotate.d"
    etc.install "examples/logrotate.conf"

    (etc/"logrotate.d").mkpath
    (var/"lib").mkpath
  end

  service do
    run [opt_sbin/"logrotate", etc/"logrotate.conf"]
    run_type :cron
    cron "25 6 * * *"
  end

  test do
    (testpath/"test.log").write("testlograndomstring")
    (testpath/"testlogrotate.conf").write <<~EOS
      #{testpath}/test.log {
        size 1
        copytruncate
      }
    EOS
    system sbin/"logrotate", "-s", "logstatus", "testlogrotate.conf"
    assert_predicate testpath/"test.log", :zero?
  end
end
