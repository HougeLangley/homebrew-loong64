class Jupp < Formula
  desc "Professional screen editor for programmers"
  homepage "https://mbsd.evolvis.org/jupp.htm"
  url "https://mbsd.evolvis.org/MirOS/dist/jupp/joe-3.1jupp41.tgz"
  version "3.1jupp41"
  sha256 "7bb8ea8af519befefff93ec3c9e32108d7f2b83216c9bc7b01aef5098861c82f"
  license "GPL-1.0-or-later"
  # Upstream HEAD in CVS: http://www.mirbsd.org/cvs.cgi/contrib/code/jupp/

  livecheck do
    url :homepage
    regex(/href=.*?joe[._-]v?(\d+(?:\.\d+)+jupp\d+)\.t/i)
  end


  bottle do
    rebuild 2
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "cbe0e68b8ab6253671be9c44fc71b69c6c1bcb770b060eb87f5099be3549f900"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  uses_from_macos "ncurses"

  on_macos do
    depends_on "gnu-sed" => :build
  end

  conflicts_with "joe", because: "both install the same binaries"

  def install
    # C23 makes `()` mean `(void)`, breaking the K&R-style `jpoly_int` callback typedef
    ENV.append_to_cflags "-std=gnu17"
    ENV.prepend_path "PATH", formula_opt_libexec("gnu-sed")/"gnubin" if OS.mac?
    system "autoreconf", "--force", "--install", "--verbose"
    system "./configure", "--enable-sysconfjoesubdir=/jupp", *std_configure_args
    system "make", "install"
  end

  test do
    require "pty"
    output = ""
    PTY.spawn({ "TERM" => "xterm" }, bin/"jupp", "test") do |r, w, _pid|
      w.write "brewx"
      begin
        r.each { |line| output += line }
      rescue Errno::EIO
        # GNU/Linux raises EIO when read is done on closed pty
      end
    end
    assert_match "File test saved", output
    assert_equal "brew", (testpath/"test").read
  end
end
