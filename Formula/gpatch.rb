class Gpatch < Formula
  desc "Apply a diff file to an original"
  homepage "https://savannah.gnu.org/projects/patch/"
  url "https://ftpmirror.gnu.org/patch/patch-2.8.1.tar.xz"
  mirror "https://ftp.gnu.org/gnu/patch/patch-2.8.1.tar.xz"
  sha256 "3240c7959c5347c8ed347e3c4201c0337bf4240d5cf09d68889e58eeaba30e17"
  license "GPL-3.0-or-later"


  deny_network_access!

  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "a159ace824487408fe5b1561bb5b2734390bf599af46748fe36b1b58efa8c778"
  end

  def install
    args = std_configure_args
    args << "--program-prefix=g" if OS.mac?

    system "./configure", *args
    system "make", "install"

    return unless OS.mac?

    # Symlink the executable into libexec/gnubin as "patch"
    (libexec/"gnubin").install_symlink bin/"gpatch" => "patch"
    (libexec/"gnuman/man1").install_symlink man1/"gpatch.1" => "patch.1"
    (libexec/"gnubin").install_symlink "../gnuman" => "man"
  end

  def caveats
    on_macos do
      <<~EOS
        GNU "patch" has been installed as "gpatch".
        If you need to use it as "patch", you can add a "gnubin" directory
        to your PATH from your bashrc like:

            PATH="#{opt_libexec}/gnubin:$PATH"
      EOS
    end
  end

  test do
    testfile = testpath/"test"
    testfile.write "homebrew\n"
    patch = <<~EOS
      1c1
      < homebrew
      ---
      > hello
    EOS
    if OS.mac?
      pipe_output("#{bin}/gpatch #{testfile}", patch)
    else
      pipe_output("#{bin}/patch #{testfile}", patch)
    end
    assert_equal "hello", testfile.read.chomp
  end
end
