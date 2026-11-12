class Inetutils < Formula
  desc "GNU utilities for networking (system stub)"
  homepage "https://www.gnu.org/software/inetutils/"
  url "file:///home/houge/infra/srv/stubs/inetutils-2.8.tar.gz"
  sha256 "9e13dd7e60d6ee3876cc34041ba7bee43ae1d79becc13bb1b137d73acabf1e97"
  version "2.8"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "dbc363585f2016d08705c74e80db06bbdce299367389f81c7e9ab9a051450f0c"
  end

  def install
    bin.mkpath
    # Bridge system inetutils binaries (hostname, ftp, telnet, etc.)
    %w[hostname dnsdomainname ftp telnet talk rexec].each do |tool|
      src = "/usr/bin/#{tool}"
      (bin/tool).make_symlink src if File.exist?(src)
    end
    (prefix/"system_stub").write "provided by AOSC OS\n"
  end

  test do
    assert_predicate prefix/"system_stub", :exist?
    assert_predicate bin/"hostname", :exist? if File.exist?("/usr/bin/hostname")
  end
end
