class Memcacheq < Formula
  desc "Queue service for memcache"
  homepage "https://github.com/stvchu/memcacheq"
  url "https://github.com/stvchu/memcacheq/archive/refs/tags/v0.2.1.tar.gz"
  sha256 "ace33313568959b5a301dda491f63af09793987b73fd15abd3fb613829eda07e"
  license "BSD-3-Clause"


  # Last release on 2014-12-16.
  deprecate! date: "2026-04-19", because: :unmaintained
  disable! date: "2027-04-19", because: :unmaintained

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "4c8062eac084d7cbf95eb6e6921bfcb4095141d9d7eb4f3d81ab9dc79c3e430c"
  end

  depends_on "berkeley-db@5" # keep berkeley-db < 6 to avoid AGPL incompatibility
  depends_on "libevent"

  allow_network_access! :test

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}", "dist/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    ENV.append "CFLAGS", "-std=gnu89"
    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--enable-threads", *std_configure_args
    system "make", "install"
  end

  test do
    port = free_port
    pid = spawn(bin/"memcacheq", "-p", port.to_s, "-H", testpath)
    sleep 5
    TCPSocket.open("localhost", port) do |sock|
      sock.puts("set brew 2 0 3\r\n100\r\n")
      assert_equal "STORED\r\n", sock.gets
      sock.puts("stats queue\r\n")
      assert_equal "STAT brew 1/0\r\n", sock.gets
    ensure
      sock.close
    end
  ensure
    Process.kill "TERM", pid
    Process.wait pid
  end
end
