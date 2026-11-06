class Zpaq < Formula
  desc "Incremental, journaling command-line archiver"
  homepage "https://mattmahoney.net/dc/zpaq.html"
  url "https://mattmahoney.net/dc/zpaq715.zip"
  version "7.15"
  sha256 "e85ec2529eb0ba22ceaeabd461e55357ef099b80f61c14f377b429ea3d49d418"
  license all_of: ["Unlicense", "MIT", :public_domain]
  revision 1
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "58b765463f954272a28da3adc0a0eacf789af82b5ebb21fec51fcc4a482982d2"
  end

  head "https://github.com/zpaq/zpaq.git", branch: "master"


  resource "test", :test do
    url "https://mattmahoney.net/dc/calgarytest2.zpaq"
    sha256 "b110688939477bbe62263faff1ce488872c68c0352aa8e55779346f1bd1ed07e"
  end

  deny_network_access!


  def install
    # When building on non-Intel this is supposed to be manually uncommented
    # from the Makefile!  (It's also missing "-D" though)
    inreplace "Makefile", "# CPPFLAGS+=NOJIT", "CPPFLAGS+=-DNOJIT" unless Hardware::CPU.intel?
    system "make"
    system "make", "check"
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    testpath.install resource("test")
    assert_match "all OK", shell_output("#{bin}/zpaq x calgarytest2.zpaq 2>&1")
  end
end
