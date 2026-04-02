class Iperf3 < Formula
  desc "Update of iperf: measures TCP, UDP, and SCTP bandwidth"
  homepage "https://github.com/esnet/iperf"
  url "https://github.com/esnet/iperf/archive/refs/tags/3.17.1.tar.gz"
  sha256 "105b953720460e7c6a7ee4d348f5a6f3549d4c4b47c5b643919635d1c1ad4c84"
  license "BSD-3-Clause"

  depends_on "openssl@3"

  def install
    system "./configure", "--prefix=#{prefix}", "--with-openssl=#{Formula["openssl@3"].opt_prefix}"
    system "make", "clean"
    system "make"
    system "make", "install"
  end

  test do
    system bin/"iperf3", "--version"
  end
end
