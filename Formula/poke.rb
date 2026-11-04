class Poke < Formula
  desc "Extensible editor for structured binary data"
  homepage "https://jemarch.net/poke"
  url "https://ftpmirror.gnu.org/poke/poke-5.0.tar.gz"
  sha256 "6873d59abe821c8111b88623ea7ad9e090892fa95c75562606dd88374e2f5b8f"
  license "GPL-3.0-or-later"


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "1cb9e29b4197ef15a794fa521bcc01f2d9efab82f7f519fab991fbc160704588"
  end

  depends_on "help2man" => :build
  depends_on "pkgconf" => :build
  depends_on "bdw-gc"
  depends_on "gettext" # needs libtextstyle
  depends_on "readline"

  uses_from_macos "ncurses"

  def install
    system "./configure", "--disable-silent-rules", "--with-lispdir=#{elisp}", *std_configure_args
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"test.pk").write <<~PK
      .file #{bin}/poke
      dump :size 4#B :ruler 0 :ascii 0
      .exit
    PK
    if OS.mac?
      assert_match "00000000: cffa edfe", shell_output("#{bin}/poke --quiet -s test.pk")
    else
      assert_match "00000000: 7f45 4c46", shell_output("#{bin}/poke --quiet -s test.pk")
    end
  end
end
