class Tmux < Formula
  desc "Terminal multiplexer"
  homepage "https://tmux.github.io/"
  url "https://github.com/tmux/tmux/releases/download/3.5a/tmux-3.5a.tar.gz"
  sha256 "16216bd0877179301b18ddf086e92aa68f9d0ab6724e3237fbb20fb3b8a1e9b4"
  license "ISC"

  depends_on "libevent"
  depends_on "ncurses"
  depends_on "pkgconf"

  def install
    cpu = Hardware::CPU.loongarch? ? "loongarch64" : Hardware.oldest_cpu
    
    ENV.append "CPPFLAGS", "-I#{Formula["libevent"].opt_include}"
    ENV.append "LDFLAGS", "-L#{Formula["libevent"].opt_lib}"
    ENV.append "PKG_CONFIG_PATH", "#{Formula["libevent"].opt_lib}/pkgconfig"
    
    system "./configure", "--prefix=#{prefix}",
                          "--build=#{cpu}-unknown-linux-gnu",
                          "--sysconfdir=#{etc}"
    system "make", "install"
    
    (pkgshare/"examples").install Dir["example*"]
  end

  test do
    system "#{bin}/tmux", "-V"
  end
end
