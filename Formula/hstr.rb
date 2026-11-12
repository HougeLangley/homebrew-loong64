class Hstr < Formula
  desc "Bash and zsh history suggest box"
  homepage "https://github.com/dvorka-oss/hstr"
  url "https://github.com/dvorka-oss/hstr/releases/download/v3.2/hstr-3.2.0-tarball.tgz"
  sha256 "abf0a8625545b2022d62bf0d1c576e3cc783c4ea7cc2ae2843c518743f77f4c9"
  license "Apache-2.0"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "e86080f25b67091521f2cfbc52f4f27a2f66b9231a765967e5f05e1581913ffe"
  end

  depends_on "pkgconf" => :build
  depends_on "readline"

  uses_from_macos "ncurses"

  def install
    system "./configure", *std_configure_args
    system "make", "install"
  end

  test do
    require "pty"
    require "io/console"

    ENV["HISTFILE"] = testpath/".hh_test"
    (testpath/".hh_test").write("test\n")

    output = ""
    PTY.spawn(bin/"hh", "-n") do |r, _w, _pid|
      r.winsize = [24, 80]
      begin
        r.each_line { |line| output += line }
      rescue Errno::EIO
        # GNU/Linux raises EIO when read is done on closed pty
      end
    end
    assert_match "test", output
  end
end
