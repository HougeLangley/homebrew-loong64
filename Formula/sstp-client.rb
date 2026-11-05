class SstpClient < Formula
  desc "SSTP (Microsoft's Remote Access Solution for PPP over SSL) client"
  homepage "https://gitlab.com/sstp-project/sstp-client"
  url "https://gitlab.com/sstp-project/sstp-client/-/releases/1.0.20/downloads/dist-gzip/sstp-client-1.0.20.tar.gz"
  sha256 "6c84b6cdcc21ebea6daeb8c5356dcdfd8681f4981a734f8485ed0b31fc30aadd"
  license "GPL-2.0-or-later"
  revision 1
  version_scheme 1
  head "https://gitlab.com/sstp-project/sstp-client.git", branch: "master"

  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "b060a72da3c5202e55ceefff7df487a76bf94101cd195d8e11343e005f07ede1"
  end



  depends_on "pkgconf" => :build
  depends_on "libevent"
  depends_on "openssl@4"

  def install
    system "./configure", "--disable-silent-rules",
                          "--disable-ppp-plugin",
                          "--with-runtime-dir=#{var}/run/sstpc",
                          *std_configure_args
    system "make", "install"

    # Create a directory needed by sstpc for privilege separation
    (var/"run/sstpc").mkpath
  end

  def caveats
    <<~EOS
      sstpc reads PPP configuration options from /etc/ppp/options. If this file
      does not exist yet, type the following command to create it:

      sudo touch /etc/ppp/options
    EOS
  end

  test do
    system sbin/"sstpc", "--version"
  end
end
