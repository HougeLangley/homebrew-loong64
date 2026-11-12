class Modules < Formula
  desc "Dynamic modification of a user's environment via modulefiles"
  homepage "https://modules.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/modules/Modules/modules-5.7.0/modules-5.7.0.tar.bz2"
  sha256 "3e3cc7582ea34f3cf8353152fae724dea00dc893f021080263f475dcaeb40520"
  license "GPL-2.0-or-later"

  livecheck do
    url :stable
    regex(%r{url=.*?/modules[._-]v?(\d+(?:\.\d+)+)\.t}i)
  end



  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "7f58b3dc603aa748d3919ae91ccce7f76ffa390bb27ce7c6ecf841c111414401"
  end

  depends_on "tcl-tk"

  uses_from_macos "less"

  def install
    tcltk = Formula["tcl-tk"]
    args = %W[
      --prefix=#{prefix}
      --datarootdir=#{share}
      --with-tcl=#{tcltk.opt_lib}
      --with-tclsh=#{tcltk.opt_bin}/tclsh
      --without-x
    ]
    args << "--with-pager=#{formula_opt_bin("less")}/less" if OS.linux?

    system "./configure", *args
    system "make", "install"
  end

  def caveats
    <<~EOS
      To activate modules, add the following at the end of your .zshrc:

        source #{opt_prefix}/init/zsh

      You will also need to restart your terminal for this change to take effect.
    EOS
  end

  test do
    assert_match "restore", shell_output("#{bin}/envml --help")
    shell, cmd = if OS.mac?
      ["zsh", "source"]
    else
      ["sh", "."]
    end
    output = shell_output("#{shell} -c '#{cmd} #{prefix}/init/#{shell}; module' 2>&1")
    assert_match version.to_s, output
  end
end
