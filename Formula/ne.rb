class Ne < Formula
  desc "Text editor based on the POSIX standard"
  homepage "https://ne.di.unimi.it/"
  url "https://github.com/vigna/ne/archive/refs/tags/3.3.4.tar.gz"
  sha256 "6958b5cd051d85dcdebbf45aeed2af077346a58d1d18ad14e1db477ce5519d29"
  license "GPL-3.0-only"
  head "https://github.com/vigna/ne.git", branch: "master"


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "e021b8869014332f2208e1763630f4f984e4ed2b6eca90c221f547131b8b7087"
  end

  depends_on "texinfo" => :build

  uses_from_macos "ncurses"

  on_linux do
    # The version of `env` in CI is too old, so we need to use brewed coreutils.
    depends_on "coreutils" => :build
  end

  def install
    # Use newer env on Linux that supports -S option.
    unless OS.mac?
      inreplace "version.pl",
                "/usr/bin/env",
                Formula["coreutils"].libexec/"gnubin/env"
    end
    ENV.deparallelize
    cd "src" do
      system "make"
    end
    system "make", "build", "PREFIX=#{prefix}", "install"
  end

  test do
    require "pty"

    ENV["TERM"] = "xterm"
    document = testpath/"test.txt"
    macros = testpath/"macros"
    document.write <<~EOS
      This is a test document.
    EOS
    macros.write <<~EOS
      GotoLine 2
      InsertString line 2
      InsertLine
      Exit
    EOS
    PTY.spawn(bin/"ne", "--macro", macros, document) do |_r, _w, pid|
      sleep 1
      Process.kill "KILL", pid
    end
    assert_equal <<~EOS, document.read
      This is a test document.
      line 2
    EOS
  end
end
