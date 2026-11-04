class Redict < Formula
  desc "Distributed key/value database"
  homepage "https://redict.io/"
  url "https://codeberg.org/redict/redict/archive/7.3.6.tar.gz"
  sha256 "868220e6b51062709420f6b2343f03c98eac113c77eefac4626ba909085504f7"
  license "LGPL-3.0-only"
  head "https://codeberg.org/redict/redict.git", branch: "main"

  bottle do
    rebuild 3
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "2d1889bb3593a4d40e752b4156495517d44aa17c408ea931c5cb4cb86a862ffd"
  end



  depends_on "openssl@4"

  def install
    system "make", "install", "PREFIX=#{prefix}", "CC=#{ENV.cc}", "BUILD_TLS=yes"

    %w[run db/redict log].each { |p| (var/p).mkpath }

    # Fix up default conf file to match our paths
    inreplace "redict.conf" do |s|
      s.gsub! "/var/run/redict_6379.pid", var/"run/redict.pid"
      s.gsub! "dir ./", "dir #{var}/db/redict/"
      s.sub!(/^bind .*$/, "bind 127.0.0.1 ::1")
    end

    etc.install "redict.conf"
    etc.install "sentinel.conf" => "redict-sentinel.conf"
  end

  service do
    run [opt_bin/"redict-server", etc/"redict.conf"]
    keep_alive true
    error_log_path var/"log/redict.log"
    log_path var/"log/redict.log"
    working_dir var
  end

  test do
    system bin/"redict-server", "--test-memory", "2"
    %w[run db/redict log].each { |p| assert_path_exists var/p, "#{var/p} doesn't exist!" }
  end
end
