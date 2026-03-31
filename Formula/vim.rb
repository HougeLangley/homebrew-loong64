class Vim < Formula
  desc "Vi 'workalike' with many additional features"
  homepage "https://www.vim.org/"
  url "https://github.com/vim/vim/archive/v9.1.1000.tar.gz"
  sha256 "c8ccd457bba5563513ab3e2088ad10d62b982682af9a9278686b48202b8c7697"
  license "Vim"

  depends_on "gettext"
  depends_on "ncurses"
  depends_on "python@3.13"

  def install
    ENV.prepend_path "PATH", Formula["python@3.13"].opt_libexec/"bin"

    cpu = Hardware::CPU.loongarch? ? "loongarch64" : Hardware.oldest_cpu

    opts = [
      "--prefix=#{prefix}",
      "--mandir=#{man}",
      "--enable-multibyte",
      "--with-tlib=ncurses",
      "--with-compiledby=Homebrew",
      "--disable-gui",
      "--without-x",
      "--disable-nls",
      "--build=#{cpu}-unknown-linux-gnu"
    ]

    system "./configure", *opts
    system "make"
    system "make", "install", "prefix=#{prefix}"

    bin.install_symlink "vim" => "vi" if build.with? "override-system-vi"
  end

  test do
    system bin/"vim", "--version"
  end
end
