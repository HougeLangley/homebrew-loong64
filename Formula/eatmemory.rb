class Eatmemory < Formula
  desc "Simple program to allocate memory from the command-line"
  homepage "https://github.com/julman99/eatmemory"
  url "https://github.com/julman99/eatmemory/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "1cbd585adcf014beaecd442454f15eeac8364eab12dde39593acc0a503b41223"
  license "MIT"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "fdb88283683a6316d5bfb4f3e74a54193fe87be78b12b231b7138786ec25a926"
  end

  def install
    system "make", "install", "PREFIX=#{prefix}", "VERSION=#{version}"
  end

  test do
    assert_match "eatmemory #{version}", shell_output("#{bin}/eatmemory --help")

    out = shell_output("#{bin}/eatmemory -t 0 10M")
    assert_match(/^Eating .+ in chunks of .+\.\.\.$/, out)
    assert_match(/^Done, sleeping for 0 seconds before exiting\.\.\.$/, out)

    pid = spawn bin/"eatmemory", "-t", "60", "10M", [:out, :err] => File::NULL
    sleep 5

    rss_kb = shell_output("ps -o rss= -p #{pid}").to_i
    assert_operator rss_kb, :>=, 10 * 1024
    assert_operator rss_kb, :<, 20 * 1024
  ensure
    if pid
      begin
        Process.kill("TERM", pid)
        Process.wait(pid)
      rescue Errno::ESRCH, Errno::ECHILD
        nil
      end
    end
  end
end
