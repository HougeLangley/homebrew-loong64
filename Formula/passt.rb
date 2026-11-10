class Passt < Formula
  desc "User-mode networking daemons for virtual machines and namespaces"
  homepage "https://passt.top/passt/about/"
  url "https://passt.top/passt/snapshot/passt-2026_10_02.cba3570.tar.xz"
  version "2026_10_02.cba3570"
  sha256 "aa75616cc43925f0bd6c05bcfbbaecd77397c03d7bd23591b34ef535be5dfcdc"
  license all_of: ["GPL-2.0-or-later", "BSD-3-Clause"]

  head "git://passt.top/passt", branch: "master"



  depends_on :linux

  def install
    args = ["prefix=#{prefix}"]
    args << "VERSION=#{version}" if build.stable?
    system "make", "install", *args
  end

  test do
    require "pty"
    PTY.spawn("#{bin}/passt --version") do |r, _w, _pid|
      sleep 1
      assert_match "passt #{version}", r.read_nonblock(1024)
    end

    pidfile = testpath/"pasta.pid"
    begin
      # This host supports user namespaces; verify successful daemon startup.
      shell_output("#{bin}/pasta --pid #{pidfile} 2>&1")
      assert_path_exists pidfile
      assert_operator pidfile.read.to_i, :>, 0
    ensure
      if pidfile.exist? && (pid = pidfile.read.to_i).positive?
        begin
          Process.kill("TERM", pid)
        rescue Errno::ESRCH
          # pasta may already have exited after the expected namespace failure
        end
      end
    end
  end
end
