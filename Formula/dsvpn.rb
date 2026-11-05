class Dsvpn < Formula
  desc "Dead Simple VPN"
  homepage "https://github.com/jedisct1/dsvpn"
  url "https://github.com/jedisct1/dsvpn/archive/refs/tags/0.1.5.tar.gz"
  sha256 "53c9ff2518acea188926a4f10d38929da7b61b6770d6ec00f73a4c82ff918c5e"
  license "MIT"
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "5d4bfaf0a8f0242458da8063c7c1f16c491dcde5dfb38176e830f8a8dd33a3d9"
  end

  head "https://github.com/jedisct1/dsvpn.git", branch: "master"



  def install
    sbin.mkpath
    system "make"
    system "make", "install", "PREFIX=#{prefix}"
  end

  def caveats
    <<~EOS
      dsvpn requires root privileges so you will need to run `sudo #{HOMEBREW_PREFIX}/sbin/dsvpn`.
      You should be certain that you trust any software you grant root privileges.
    EOS
  end

  test do
    expected = if OS.mac?
      "tun device creation: Operation not permitted"
    else
      "Unable to automatically determine the gateway IP"
    end
    assert_match expected, shell_output("#{sbin}/dsvpn client /dev/zero 127.0.0.1 0 2>&1", 1)
  end
end
