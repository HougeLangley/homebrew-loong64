class Iperf3 < Formula
  desc "Update of iperf: measures TCP, UDP, and SCTP bandwidth"
  homepage "https://github.com/esnet/iperf"
  url "https://downloads.es.net/pub/iperf/iperf-3.22.tar.gz"
  sha256 "1c0d0fb02c52626111d6e132db80edfbf27bbaff8bd9245df2a371dcb0b35a92"
  license "BSD-3-Clause"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "6a976b235c384977df3b83867501fb234a05fca0ebf1058f04db4b1823198d34"
  end

  livecheck do
    url "https://downloads.es.net/pub/iperf/"
    regex(/href=.*?iperf[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  head do
    url "https://github.com/esnet/iperf.git", branch: "master"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  depends_on "openssl@4"

  allow_network_access! :test

  def install
    # --- 追加缺失库 ---
    ENV.append "LIBS", "-lm"
    ENV.append "LDFLAGS", "-lm"
    system "./bootstrap.sh" if build.head?
    system "./configure", "LIBS=-lm", "--disable-silent-rules",
                          "--disable-profiling",
                          "--with-openssl=#{formula_opt_prefix("openssl@4")}",
                          *std_configure_args
    system "make", "LIBS=-lm", "clean" # there are pre-compiled files in the tarball
    system "make", "LIBS=-lm", "install"
  end

  test do
    port = free_port
    pid = spawn bin/"iperf3", "--server", "--port", port.to_s
    sleep 1
    assert_match "Bitrate", shell_output("#{bin}/iperf3 --client 127.0.0.1 --port #{port} --time 1")
  ensure
    Process.kill("SIGINT", pid)
    Process.wait(pid)
  end
end
