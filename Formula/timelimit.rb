class Timelimit < Formula
  desc "Limit a process's absolute execution time"
  homepage "https://devel.ringlet.net/sysutils/timelimit/"
  url "https://devel.ringlet.net/files/sys/timelimit/timelimit-1.9.5.tar.xz"
  sha256 "96b39c61a850d3395eaf4dde5fd22c290854d42ff69f192b12aef05d99d5ddbb"
  license "BSD-2-Clause"
  head "https://gitlab.com/timelimit/timelimit.git", branch: "master"

  livecheck do
    url "https://devel.ringlet.net/files/sys/timelimit/"
    regex(/href=.*?timelimit[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "ecf61c3032f2c73921a6138fe07fa2e9067725f08802bf75bdad746d13f03e26"
  end

  def install
    # don't install for specific users
    inreplace "Makefile", "-o ${BINOWN} -g ${BINGRP}", ""
    inreplace "Makefile", "-o ${SHAREOWN} -g ${SHAREGRP}", ""

    args = %W[LOCALBASE=#{prefix} MANDIR=#{man}/man]

    system "make", "check", *args
    system "make", "install", *args
  end

  test do
    assert_match "timelimit: sending warning signal 15",
      shell_output("#{bin}/timelimit -p -t 1 sleep 5 2>&1", 143).chomp
  end
end
