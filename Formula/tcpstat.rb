class Tcpstat < Formula
  desc "Active TCP connections monitoring tool"
  homepage "https://github.com/jtt/tcpstat"
  url "https://github.com/jtt/tcpstat/archive/refs/tags/rel-0-1.tar.gz"
  version "0.1"
  sha256 "366a221950759015378775862a7499aaf727a3a9de67b15463b0991c2362fdaf"
  license "BSD-2-Clause"
  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "73d8a0f39b2633ec6d2d24659e5523adc9104227535d3e84a11422b86b1208d7"
  end

  head "https://github.com/jtt/tcpstat.git", branch: "master"


  uses_from_macos "ncurses"


  def install
    # Workaround for arm64 linux. Upstream isn't actively maintained
    if OS.linux? && Hardware::CPU.arm?
      inreplace "Makefile" do |s|
        s.change_make_var! "CFLAGS", "#{s.get_make_var("CFLAGS")} -fsigned-char"
      end
    end

    system "make"
    bin.install "tcpstat"
  end

  test do
    ENV["TERM"] = "xterm"
    assert_match "Connections:", pipe_output(bin/"tcpstat", "q")
  end
end
