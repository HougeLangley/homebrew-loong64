class MemcacheTop < Formula
  desc "Grab real-time stats from memcache"
  homepage "https://code.google.com/archive/p/memcache-top/"
  url "https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/memcache-top/memcache-top-v0.6"
  sha256 "d5f896a9e46a92988b782e340416312cc480261ce8a5818db45ccd0da8a0f22a"
  license "BSD-3-Clause"


  allow_network_access! :test

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "d680eb3ab14a2c5acc5f192d1507742b49411668940ee0603d1ecec912fede49"
  end

  def install
    bin.install "memcache-top-v#{version}" => "memcache-top"
  end

  test do
    pid = spawn bin/"memcache-top", "--instances=127.0.0.1:#{free_port}", "--port=#{free_port}"
    sleep 10
    assert_nil Process.wait(pid, Process::WNOHANG), "memcache-top exited early"
    Process.kill "TERM", pid
  ensure
    Process.kill "TERM", pid
    Process.wait pid
  end
end
