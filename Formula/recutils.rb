class Recutils < Formula
  desc "Tools to work with human-editable, plain text data files"
  homepage "https://www.gnu.org/software/recutils/"
  url "https://ftpmirror.gnu.org/recutils/recutils-1.9.tar.gz"
  mirror "https://ftp.gnu.org/gnu/recutils/recutils-1.9.tar.gz"
  sha256 "6301592b0020c14b456757ef5d434d49f6027b8e5f3a499d13362f205c486e0e"
  license "GPL-3.0-or-later"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "df22dea798e51fcc488e72768073bbcb189a486515e519a88d1b74797ea3db03"
  end

  on_linux do
    depends_on "libgcrypt"
  end

  # Fix -flat_namespace being used on Big Sur and later.
  patch do
    file "Patches/libtool/configure-big_sur.diff"
    type :unofficial
  end

  def install
    # The brew-prefix xlocale.h shim makes gnulib think the obsolete header
    # exists; force the negative cache so generated locale.h skips it.
    ENV["ac_cv_header_xlocale_h"] = "no"
    ENV.append_to_cflags "-std=gnu17 -Wno-error=implicit-int -Wno-error=implicit-function-declaration"
    # Fix compile with newer Clang. Remove in the next release.
    # Ref: http://git.savannah.gnu.org/cgit/recutils.git/commit/?id=e154822aeec19cb790f8618ee740875c048859e4
    ENV.append_to_cflags "-Wno-implicit-function-declaration" if DevelopmentTools.clang_build_version >= 1403

    system "./configure", "--datarootdir=#{elisp}",
                          "--disable-silent-rules",
                          "--disable-bash-builtins",
                          *std_configure_args
    system "make", "install"
  end

  test do
    (testpath/"test.csv").write <<~CSV
      a,b,c
      1,2,3
    CSV
    system bin/"csv2rec", "test.csv"

    (testpath/"test.rec").write <<~EOS
      %rec: Book
      %mandatory: Title

      Title: GNU Emacs Manual
    EOS
    system bin/"recsel", "test.rec"
  end
end
