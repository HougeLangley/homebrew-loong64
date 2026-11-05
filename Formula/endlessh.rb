class Endlessh < Formula
  desc "SSH tarpit that slowly sends an endless banner"
  homepage "https://github.com/skeeto/endlessh"
  url "https://github.com/skeeto/endlessh/archive/refs/tags/1.1.tar.gz"
  sha256 "786cea9e2c8e0a37d3d4ecd984ca4a0ae0b2d6e2b8da37e3cdbb9d49ccdecbf0"
  license "Unlicense"
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "2e3058fe1e209a0839c9a3a6f54c5746085d33ff90727777cf632497f785e2fb"
  end

  head "https://github.com/skeeto/endlessh.git", branch: "master"


  uses_from_macos "netcat" => :test

  allow_network_access! :test


  def install
    inreplace "endlessh.c", "/etc/endlessh/", "#{pkgetc}/"
    system "make", "PREFIX=#{prefix}", "install"
  end

  test do
    port = free_port
    pid = spawn(bin/"endlessh", "-p", port.to_s)

    sleep 5

    system "nc", "-z", "localhost", port
  ensure
    Process.kill "HUP", pid
  end
end
