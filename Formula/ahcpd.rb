class Ahcpd < Formula
  desc "Autoconfiguration protocol for IPv6 and IPv6/IPv4 networks"
  homepage "https://www.irif.fr/~jch/software/ahcp/"
  url "https://www.irif.fr/~jch/software/files/ahcpd-0.53.tar.gz"
  mirror "https://deb.debian.org/debian/pool/main/a/ahcpd/ahcpd_0.53.orig.tar.gz"
  sha256 "a4622e817d2b2a9b878653f085585bd57f3838cc546cca6028d3b73ffcac0d52"
  license "MIT"

  livecheck do
    url "https://www.irif.fr/~jch/software/files/"
    regex(/href=.*?ahcpd[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  allow_network_access! :test

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "c5b7d73f983031da8df8cbb3af00f3179439f910c90005328d920d519113799e"
  end

  def install
    args = ["PREFIX=", "TARGET=#{prefix}"]
    # LDLIBS='' fixes: ld: library not found for -lrt
    args << "LDLIBS=" if OS.mac?

    system "make", "install", *args
    share.install prefix/"man"
  end

  test do
    pid_file = testpath/"ahcpd.pid"
    log_file = testpath/"ahcpd.log"
    mkdir testpath/"leases"

    (testpath/"ahcpd.conf").write <<~EOS
      mode server

      prefix fde6:20f5:c9ac:358::/64
      prefix 192.168.4.128/25
      lease-dir #{testpath}/leases
      name-server fde6:20f5:c9ac:358::1
      name-server 192.168.4.1
      ntp-server 192.168.4.2
    EOS

    system bin/"ahcpd", "-c", "ahcpd.conf", "-I", pid_file, "-L", log_file, "-D", "lo0"
    sleep(2)

    assert_path_exists pid_file, "The file containing the PID of the child process was not created."
    assert_path_exists log_file, "The file containing the log was not created."

    Process.kill("TERM", pid_file.read.to_i)
  end
end
