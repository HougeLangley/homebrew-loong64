class Nuttcp < Formula
  desc "Network performance measurement tool"
  homepage "http://www.nuttcp.net/nuttcp/"
  url "https://www.nuttcp.net/nuttcp/nuttcp-8.2.2.tar.bz2"
  mirror "https://src.fedoraproject.org/repo/pkgs/nuttcp/nuttcp-8.2.2.tar.bz2/sha512/46cc979f034d68f8a4c8a8ad9f3d35ce9e5180b8677b967b182acbc1d98bb3c23dd6fc77e2277922ae0c9b15a50a2e9c84048c694520e99c77492ceed97fda06/nuttcp-8.2.2.tar.bz2"
  sha256 "7ead7a89e7aaa059d20e34042c58a198c2981cad729550d1388ddfc9036d3983"
  license "GPL-2.0-only"

  livecheck do
    url :homepage
    regex(/href=.*?nuttcp[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  # Last release on 2020-05-11 and homepage certificate was invalid on deprecation date
  deprecate! date: "2026-09-16", because: :unmaintained
  disable! date: "2027-03-16", because: :unmaintained

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "087955a96e6e6719a8b742caf41fda093cf85251954d18a6cc80cc3fb9c31764"
  end

  def install
    system "make", "APP=nuttcp",
           "CC=#{ENV.cc}", "CFLAGS=#{ENV.cflags}"
    bin.install "nuttcp"
    man8.install "nuttcp.cat" => "nuttcp.8"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/nuttcp -V")
  end
end
