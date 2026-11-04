class Empty < Formula
  desc "Lightweight Expect-like PTY tool for shell scripts"
  homepage "https://empty.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/empty/empty/empty-0.6.23d/empty-0.6.23d.tgz"
  sha256 "9ad495d52b942e3fd858643536d8d12e282568214300954d4518d8c22b893585"
  license "BSD-3-Clause"

  livecheck do
    url :stable
    regex(%r{url=.*?/empty[._-]v?(\d+(?:\.\d+)+[a-z]?)\.t}i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "f2b389746442e7d9a3ca97d84d5336419cd120728e8e46ac9c579e6aab38629d"
  end

  def install
    # Fix incorrect link order in Linux
    inreplace "Makefile", "${LIBS} -o empty empty.c", "empty.c ${LIBS} -o empty" if OS.linux?

    system "make", "all"
    system "make", "PREFIX=#{prefix}", "install"
    rm_r("#{prefix}/man")
    man1.install "empty.1"
    pkgshare.install "examples"
  end

  test do
    require "pty"

    # Looks like PTY must be attached for the process to be started
    PTY.spawn(bin/"empty", "-f", "-i", "in", "-o", "out", "-p", "test.pid", "cat") { |_r, _w, pid| Process.wait(pid) }
    system bin/"empty", "-s", "-o", "in", "Hello, world!\n"
    assert_equal "Hello, world!\n", shell_output("#{bin}/empty -r -i out")

    system bin/"empty", "-k", File.read(testpath/"test.pid")
    sleep 1
    %w[in out test.pid].each { |file| refute_path_exists testpath/file }
  end
end
