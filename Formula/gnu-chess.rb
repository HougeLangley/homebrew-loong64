class GnuChess < Formula
  desc "Chess-playing program"
  homepage "https://www.gnu.org/software/chess/"
  url "https://ftpmirror.gnu.org/chess/gnuchess-6.3.0.tar.gz"
  mirror "https://ftp.gnu.org/gnu/chess/gnuchess-6.3.0.tar.gz"
  sha256 "0b37bec2098c2ad695b7443e5d7944dc6dc8284f8d01fcc30bdb94dd033ca23a"
  license "GPL-3.0-or-later"

  livecheck do
    url :stable
    regex(/href=.*?gnuchess[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  head do
    url "https://svn.savannah.gnu.org/svn/chess/trunk"
    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "help2man" => :build
    depends_on "gettext"
  end

  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "84f0d2c97237b2b4a267810812623dbd1358f650c52d8e9e25a324618fe2ba27"
  end

  depends_on "readline"

  resource "book" do
    url "https://ftpmirror.gnu.org/chess/book_1.02.pgn.gz"
    sha256 "deac77edb061a59249a19deb03da349cae051e52527a6cb5af808d9398d32d44"

    livecheck do
      url "https://ftpmirror.gnu.org/chess/"
      regex(/href=.*?book[._-]v?(\d+(?:\.\d+)+\.pgn)/i)
    end
  end

  def install
    #  Fix "install-sh: Permission denied" issue
    chmod "+x", "install-sh"

    if build.head?
      system "autoreconf", "--force", "--install", "--verbose"
      chmod 0755, "install-sh"
    end

    system "./configure", *std_configure_args
    system "make", "install"

    resource("book").stage do
      doc.install "book_1.02.pgn"
    end
  end

  def caveats
    <<~EOS
      This formula also downloads the additional opening book.  The
      opening book is a PGN file located in #{doc} that can be added
      using gnuchess commands.
    EOS
  end

  test do
    assert_match "GNU Chess #{version}", shell_output("#{bin}/gnuchess --version")
  end
end
