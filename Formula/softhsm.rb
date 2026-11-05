class Softhsm < Formula
  desc "Cryptographic store accessible through a PKCS#11 interface"
  homepage "https://www.softhsm.org/"
  license "BSD-2-Clause"
  head "https://github.com/softhsm/SoftHSMv2.git", branch: "main"

  bottle do
    rebuild 2
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "9cb417699fed5e505e97cacbcd8cf346a49592b3867091112fa60692df859bde"
  end

  stable do
    url "https://github.com/softhsm/SoftHSMv2/archive/refs/tags/2.7.0.tar.gz"
    sha256 "be14a5820ec457eac5154462ffae51ba5d8a643f6760514d4b4b83a77be91573"

    # OpenSSL 4.0 support was added with memory leak fixes
    patch do
      url "https://github.com/softhsm/SoftHSMv2/commit/57e10cbbe75069be92c7e9720c180a05833481fc.patch?full_index=1"
      sha256 "d60af158e0fcbb72458292b86455ec949d4c550cd009274841cbe94b4ded06dd"
      type :backport
    end
    patch do
      url "https://github.com/softhsm/SoftHSMv2/commit/d23ea09d318c03c033420d065f1c64b019cc94ed.patch?full_index=1"
      sha256 "b8f13d1d584c39d0c04443d756fdb7dadbfe8ab056dd7d290313afcfd93d96ca"
      type :backport
    end
  end



  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkgconf" => :build
  depends_on "openssl@4"

  deny_network_access!

  def install
    system "./autogen.sh"
    system "./configure", "--disable-silent-rules",
                          "--localstatedir=#{var}",
                          "--sysconfdir=#{pkgetc}",
                          "--with-crypto-backend=openssl",
                          "--with-openssl=#{formula_opt_prefix("openssl@4")}",
                          "--disable-gost",
                          *std_configure_args
    system "make", "install"

    (var/"lib/softhsm/tokens").mkpath
  end

  test do
    (testpath/"softhsm2.conf").write("directories.tokendir = #{testpath}")
    ENV["SOFTHSM2_CONF"] = testpath/"softhsm2.conf"
    system bin/"softhsm2-util", "--init-token", "--slot", "0",
                                "--label", "testing", "--so-pin", "1234",
                                "--pin", "1234"
    system bin/"softhsm2-util", "--show-slots"
  end
end
