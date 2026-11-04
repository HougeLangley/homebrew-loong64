class Uftp < Formula
  desc "Secure, reliable, efficient multicast file transfer program"
  homepage "https://uftp-multicast.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/uftp-multicast/source-tar/uftp-5.0.4.tar.gz"
  sha256 "50df3f0e59ebd59ed1b9bc8af991a0187df14d928188ff5f62c3d65adcd113ab"
  license "GPL-3.0-or-later" => { with: "openvpn-openssl-exception" }

  livecheck do
    url :stable
    regex(%r{url=.*?/uftp[._-]v?(\d+(?:\.\d+)+)\.t}i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "a0efe00b0281749b27cc7a335029c99f68d858004874397d507ab87d20b6f3ad"
  end

  depends_on "openssl@4"

  def install
    system "make", "OPENSSL=#{formula_opt_prefix("openssl@4")}", "DESTDIR=#{prefix}", "install"
    # the makefile installs into DESTDIR/usr/..., move everything up one and remove usr
    # the project maintainer was contacted via sourceforge on 12-Feb, he responded WONTFIX on 13-Feb
    prefix.install (prefix/"usr").children
    (prefix/"usr").unlink
  end

  service do
    run [opt_bin/"uftpd", "-d"]
    keep_alive true
    working_dir var
  end

  test do
    system bin/"uftp_keymgt"
  end
end
