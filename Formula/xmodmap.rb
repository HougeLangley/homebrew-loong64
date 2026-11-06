class Xmodmap < Formula
  desc "Modify keymaps and pointer button mappings in X"
  homepage "https://gitlab.freedesktop.org/xorg/app/xmodmap"
  url "https://www.x.org/releases/individual/app/xmodmap-1.0.12.tar.xz"
  sha256 "fc54b9b5bbf2ae58ba8f9d42bd051c41c7438377400c42c17d7496d19e1bb3ce"
  license "MIT-open-group"




  depends_on "pkgconf" => :build
  depends_on "xorgproto" => :build
  depends_on "xorg-server" => :test

  depends_on "libx11"

  def install
    system "./configure", *std_configure_args
    system "make"
    system "make", "install"
  end

  test do
    IO.pipe do |read_io, write_io|
      xvfb = formula_opt_bin("xorg-server")/"Xvfb"
      pid = spawn(xvfb, "-displayfd", write_io.fileno.to_s, "-listen", "tcp", write_io => write_io)
      write_io.close
      ENV["DISPLAY"] = ":#{read_io.read.strip}"
      assert_match "pointer buttons defined", shell_output("#{bin}/xmodmap -pp")
    ensure
      if pid
        Process.kill "TERM", pid
        Process.wait pid
      end
    end
  end
end
