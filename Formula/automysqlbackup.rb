class Automysqlbackup < Formula
  desc "Automate MySQL backups"
  homepage "https://sourceforge.net/projects/automysqlbackup/"
  url "https://downloads.sourceforge.net/project/automysqlbackup/AutoMySQLBackup/AutoMySQLBackup%20VER%203.0/automysqlbackup-v3.0_rc6.tar.gz"
  version "3.0-rc6"
  sha256 "889e064d086b077e213da11e937ea7242a289f9217652b9051c157830dc23cc0"
  license "GPL-2.0-or-later"

  livecheck do
    url :stable
    regex(%r{url=.*?/automysqlbackup[._-]v?(\d+(?:\.\d+)+(?:[._-]?rc\d+)?)\.t}i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "f25c6cbc0a9024b25908ab07ed227b9c319b2891e9e5f0f7c2229b148b6d4c68"
  end

  def install
    inreplace "automysqlbackup" do |s|
      s.gsub! "/etc", etc
      s.gsub! "/var", var
    end
    inreplace "automysqlbackup.conf", "/var", var

    conf_path = (etc/"automysqlbackup")
    conf_path.install "automysqlbackup.conf" unless (conf_path/"automysqlbackup.conf").exist?
    sbin.install "automysqlbackup"
  end

  def caveats
    <<~EOS
      You will have to edit
        #{etc}/automysqlbackup/automysqlbackup.conf
      to set AutoMySQLBackup up to find your database and backup directory.

      The included service will run AutoMySQLBackup every day at 04:00.
    EOS
  end

  service do
    run opt_sbin/"automysqlbackup"
    working_dir HOMEBREW_PREFIX
    run_type :cron
    cron "0 4 * * *"
    log_path var/"log/automysqlbackup.log"
    error_log_path var/"log/automysqlbackup.log"
  end

  test do
    system sbin/"automysqlbackup", "--help"
  end
end
