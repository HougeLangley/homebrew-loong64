class Memcached < Formula
  desc "High performance, distributed memory object caching system"
  homepage "https://memcached.org/"
  url "https://www.memcached.org/files/memcached-1.6.45.tar.gz"
  sha256 "d362c64e6d8d5287153501eabf7c85b4a761432fbf53f5d7b085d0bb1653c1dd"
  license "BSD-3-Clause"
  revision 1

  livecheck do
    url :homepage
    regex(/href=.*?memcached[._-]v?(\d+(?:\.\d+){2,})\./i)
  end


  head do
    url "https://github.com/memcached/memcached.git", branch: "master"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
  end

  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "8dbc006e5fd58de26cf40036a48ced2d45214008d30ebecacc29340e07357e9d"
  end

  depends_on "libevent"
  depends_on "openssl@4"

  def install
    # Workaround to disable sandbox feature due to https://github.com/memcached/memcached/issues/1313
    ENV["ac_cv_header_sandbox_h"] = "no" if OS.mac? && MacOS.version >= :golden_gate

    system "./autogen.sh" if build.head?
    system "./configure", "--disable-coverage", "--enable-tls", *std_configure_args
    system "make", "install"
  end

  service do
    run [opt_bin/"memcached", "-l", "localhost"]
    working_dir HOMEBREW_PREFIX
    keep_alive true
    run_type :immediate
  end

  test do
    pidfile = testpath/"memcached.pid"
    port = free_port
    args = %W[
      --listen=127.0.0.1
      --port=#{port}
      --daemon
      --pidfile=#{pidfile}
    ]
    args << "--user=#{ENV["USER"]}" if OS.linux? && ENV["HOMEBREW_GITHUB_ACTIONS"]
    system bin/"memcached", *args
    sleep 1
    assert_path_exists pidfile, "Failed to start memcached daemon"
    pid = (testpath/"memcached.pid").read.chomp.to_i
    Process.kill "TERM", pid
  end
end
