class GnuIndent < Formula
  desc "C code prettifier"
  homepage "https://www.gnu.org/software/indent/"
  url "https://ftpmirror.gnu.org/indent/indent-2.2.13.tar.gz"
  mirror "https://ftp.gnu.org/gnu/indent/indent-2.2.13.tar.gz"
  sha256 "9e64634fc4ce6797b204bcb8897ce14fdd0ab48ca57696f78767c59cae578095"
  license "GPL-3.0-or-later"


  on_macos do
    depends_on "gettext"
  end

  on_system :linux, macos: :ventura_or_newer do
    depends_on "texinfo" => :build
  end

  bottle do
    rebuild 2
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "c7bd8d0927af2f43a8a11f19a731b387fb46fd2cc3e78cde3e7fc7738f37e8eb"
  end

  def install
    if OS.mac?
      ENV.append_to_cflags "-D_DARWIN_C_SOURCE"
      args = ["--program-prefix=g"]
    end
    system "./configure", *args, *std_configure_args
    system "make", "install"

    return unless OS.mac?

    (libexec/"gnubin").install_symlink bin/"gindent" => "indent"
    (libexec/"gnuman/man1").install_symlink man1/"gindent.1" => "indent.1"
    (libexec/"gnubin").install_symlink "../gnuman" => "man"
  end

  def caveats
    on_macos do
      <<~EOS
        GNU "indent" has been installed as "gindent".
        If you need to use it as "indent", you can add a "gnubin" directory
        to your PATH from your bashrc like:

            PATH="#{opt_libexec}/gnubin:$PATH"
      EOS
    end
  end

  test do
    (testpath/"test.c").write("int main(){ return 0; }")
    indent = OS.mac? ? "gindent" : "indent"
    system bin/indent, "test.c"
    assert_equal <<~C, File.read("test.c")
      int
      main ()
      {
        return 0;
      }
    C
  end
end
