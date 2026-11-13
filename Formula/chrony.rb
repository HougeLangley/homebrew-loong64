class Chrony < Formula
  desc "Versatile implementation of the Network Time Protocol (NTP)"
  homepage "https://chrony-project.org"
  url "https://chrony-project.org/releases/chrony-4.9.tar.gz"
  sha256 "4924c6f530105bcd5b9e9e33c48a2ae1bfd889222c8480bc41601110efc864d0"
  license "GPL-2.0-only"

  livecheck do
    url "https://chrony-project.org/download.html"
    regex(/href=.*?chrony[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end



  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "f6a87740e5148e63a684b5a286ab3a5d6ddaa2fe52abb7985dba8a6559c8d9a9"
  end

  depends_on "pkgconf" => :build
  depends_on "gnutls"
  depends_on "nettle"

  uses_from_macos "libedit"

  def install
    system "./configure", "--localstatedir=#{var}", *std_configure_args
    system "make", "install"
  end

  test do
    (testpath/"test.conf").write "pool pool.ntp.org iburst\n"
    output = shell_output("#{sbin}/chronyd -Q -f #{testpath}/test.conf 2>&1")
    assert_match(/System clock wrong by -?\d+\.\d+ seconds \(ignored\)/, output)
  end
end
