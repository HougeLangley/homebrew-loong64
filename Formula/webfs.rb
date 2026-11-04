class Webfs < Formula
  desc "HTTP server for purely static content"
  homepage "https://linux.bytesex.org/misc/webfs.html"
  url "https://www.kraxel.org/releases/webfs/webfs-1.21.tar.gz"
  sha256 "98c1cb93473df08e166e848e549f86402e94a2f727366925b1c54ab31064a62a"
  license "GPL-2.0-or-later"
  revision 2

  livecheck do
    url "https://www.kraxel.org/releases/webfs/"
    regex(/href=.*?webfs[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "5097b4a6b69805a01f2d9105a45351ed2c9a140b3c50b64646cf2f71dc739785"
  end

  depends_on "httpd" => :build
  depends_on "openssl@4"

  patch :p0 do
    file "Patches/webfs/patch-ls.c"
    type :unofficial
  end

  def install
    ENV["prefix"]=prefix
    args = ["mimefile=#{etc}/httpd/mime.types"]
    args << "SHELL=bash" unless OS.mac?
    system "make", "install", *args
  end

  test do
    port = free_port
    pid = spawn bin/"webfsd", "-F", "-p", port.to_s
    sleep 5
    assert_match %r{webfs/1.21}, shell_output("curl localhost:#{port}")
  ensure
    Process.kill("SIGINT", pid)
    Process.wait(pid)
  end
end
