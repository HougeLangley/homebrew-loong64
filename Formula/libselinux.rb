class Libselinux < Formula
  desc "SELinux library and simple utilities"
  homepage "https://github.com/SELinuxProject/selinux"
  url "https://github.com/SELinuxProject/selinux/releases/download/3.11/libselinux-3.11.tar.gz"
  sha256 "73d419c6e20e874adaa4019372cbd097eecf4d276e13f27ec5e67d35c0bd203c"
  license :public_domain

  livecheck do
    url :stable
    regex(/^libselinux[._-]v?(\d+(?:\.\d+)+)$/i)
  end


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "384c2231279fe85796eeb9320f8161d3935e439755585d798009f7e72e9800ff"
  end

  depends_on "pkgconf" => :build
  depends_on "libsepol"
  depends_on :linux
  depends_on "pcre2"

  def install
    system "make", "install", "PREFIX=#{prefix}", "SHLIBDIR=#{lib}"
  end

  test do
    assert_match(/^(Enforcing|Permissive|Disabled)$/, shell_output(sbin/"getenforce").chomp)
  end
end
