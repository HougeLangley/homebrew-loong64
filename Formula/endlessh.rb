class Endlessh < Formula
  desc "SSH tarpit that slowly sends an endless banner"
  homepage "https://github.com/skeeto/endlessh"
  url "https://github.com/skeeto/endlessh/archive/refs/tags/1.1.tar.gz"
  sha256 "786cea9e2c8e0a37d3d4ecd984ca4a0ae0b2d6e2b8da37e3cdbb9d49ccdecbf0"
  license "Unlicense"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "6d58e5a160bda8ace693fe1ecfeb0a47ebba152b37f1476e8aaf0c8e2eaaf9d1"
  end

  head "https://github.com/skeeto/endlessh.git", branch: "master"


  allow_network_access! :test


  def install
    inreplace "endlessh.c", "/etc/endlessh/", "#{pkgetc}/"
    system "make", "PREFIX=#{prefix}", "install"
  end

  test do
    require "socket"
    port = free_port
    pid = spawn(bin/"endlessh", "-p", port.to_s)

    sleep 5

    TCPSocket.new("127.0.0.1", port).close
  ensure
    Process.kill "HUP", pid
  end
end
