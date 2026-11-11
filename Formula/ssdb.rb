class Ssdb < Formula
  desc "NoSQL database supporting many data structures: Redis alternative"
  homepage "https://ssdb.io/"
  url "https://github.com/ideawu/ssdb/archive/refs/tags/1.9.9.tar.gz"
  sha256 "a32009950114984d6e468e10d964b0ef1e846077b69d7c7615715fdfa01aaf6e"
  license "BSD-3-Clause"
  head "https://github.com/ideawu/ssdb.git", branch: "master"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "0000000000000000000000000000000000000000000000000000000000000000"
  end

  depends_on "autoconf" => :build

  def install
    # Avoid building the bundled leveldb with `-msse4.2 -DLEVELDB_PLATFORM_POSIX_SSE`
    # in order to work around an Apple Silicon build error on SSE code:
    # port/port_posix_sse.cc:58:3: error: use of undeclared identifier '__get_cpuid'
    # TODO: Remove when bundled leveldb is updated or build allows linking system library
    if Hardware::CPU.arm?
      inreplace "deps/leveldb-1.20/build_detect_platform", /(PLATFORM_SSEFLAGS=)"-msse4\.2"$/, "\\1"
    end

    inreplace "tools/ssdb-cli", /^DIR=.*$/, "DIR=#{prefix}"

    system "make", "CC=#{ENV.cc}", "CXX=#{ENV.cxx}"
    system "make", "install", "PREFIX=#{prefix}"

    %w[bench cli dump repair server].each do |suffix|
      bin.install "#{prefix}/ssdb-#{suffix}"
    end

    ["run", "db/ssdb", "db/ssdb_slave", "log"].each do |dir|
      (var/dir).mkpath
    end

    inreplace "ssdb.conf" do |s|
      s.gsub! "work_dir = ./var", "work_dir = #{var}/db/ssdb/"
      s.gsub! "pidfile = ./var/ssdb.pid", "pidfile = #{var}/run/ssdb.pid"
      s.gsub! "\toutput: log.txt", "\toutput: #{var}/log/ssdb.log"
    end

    inreplace "ssdb_slave.conf" do |s|
      s.gsub! "work_dir = ./var_slave", "work_dir = #{var}/db/ssdb_slave/"
      s.gsub! "pidfile = ./var_slave/ssdb.pid", "pidfile = #{var}/run/ssdb_slave.pid"
      s.gsub! "\toutput: log_slave.txt", "\toutput: #{var}/log/ssdb_slave.log"
    end

    etc.install "ssdb.conf"
    etc.install "ssdb_slave.conf"
  end

  service do
    run [opt_bin/"ssdb-server", etc/"ssdb.conf"]
    keep_alive successful_exit: false
    error_log_path var/"log/ssdb.log"
    log_path var/"log/ssdb.log"
    working_dir var
  end

  test do
    pid = fork do
      Signal.trap("TERM") do
        system(bin/"ssdb-server", "-d", "#{HOMEBREW_PREFIX}/etc/ssdb.conf")
        exit
      end
    end
    sleep(3)
    Process.kill("TERM", pid)
  end
end
