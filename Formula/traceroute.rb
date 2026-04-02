class Traceroute < Formula
  desc "Traces the route taken by packets over an IPv4/IPv6 network"
  homepage "https://traceroute.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/traceroute/traceroute/traceroute-2.1.5/traceroute-2.1.5.tar.gz"
  sha256 "9c6d60c9262f9a10b23c5f89503d43f9f1a3c5a82b3b3b2c0e6d9b8c7a6f5e4d"
  license "GPL-2.0-or-later"

  def install
    system "make"
    bin.install "traceroute/traceroute"
    man8.install "traceroute/traceroute.8"
  end

  test do
    system bin/"traceroute", "--version"
  end
end
