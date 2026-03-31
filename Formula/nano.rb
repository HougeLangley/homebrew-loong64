class Nano < Formula
  desc "Free (GNU) replacement for the Pico text editor"
  homepage "https://www.nano-editor.org/"
  url "https://www.nano-editor.org/dist/v8/nano-8.7.1.tar.xz"
  sha256 "fc89da8f1a8a7dd470d90cc47c89700a0aa8a7c0311fb260f7b83ec66bc7721b"
  license "GPL-3.0-or-later"

  depends_on "gettext"
  depends_on "ncurses"

  def install
    cpu = Hardware::CPU.loongarch? ? "loongarch64" : Hardware.oldest_cpu
    
    system "./configure", "--prefix=#{prefix}",
                          "--build=#{cpu}-unknown-linux-gnu",
                          "--disable-debug",
                          "--disable-dependency-tracking",
                          "--enable-nanorc",
                          "--enable-utf8"
    system "make", "install"
    doc.install "sample.nanorc"
  end

  test do
    system "#{bin}/nano", "--version"
  end
end
