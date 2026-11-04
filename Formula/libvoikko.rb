class Libvoikko < Formula
  desc "Linguistic software and Finnish dictionary"
  homepage "https://voikko.puimula.org/"
  url "https://www.puimula.org/voikko-sources/libvoikko/libvoikko-4.3.3.tar.gz"
  sha256 "d1162965c61de44f72162fd87ec1394bd4f90f87bc8152d13fe4ae692fdc73fa"
  license "GPL-2.0-or-later"

  livecheck do
    url "https://www.puimula.org/voikko-sources/libvoikko/"
    regex(/href=.*?libvoikko[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "eb2ef8b2987b66e284c90f82de02675baf4f0dbc345ad815518297902ee93cea"
  end

  depends_on "foma" => :build
  depends_on "pkgconf" => :build
  depends_on "hfstospell"

  uses_from_macos "python" => :build

  resource "voikko-fi" do
    url "https://www.puimula.org/voikko-sources/voikko-fi/voikko-fi-2.5.tar.gz"
    sha256 "3bc9b0a0562526173957bf23b5caaf57b60ecc53be63fc16874118002ec620f1"

    livecheck do
      url "https://www.puimula.org/voikko-sources/voikko-fi/"
      regex(/href=.*?voikko-fi[._-]v?(\d+(?:\.\d+)+)\.t/i)
    end
  end

  def install
    system "./configure", "--disable-silent-rules",
                          "--with-dictionary-path=#{HOMEBREW_PREFIX}/lib/voikko",
                          *std_configure_args
    system "make", "install"

    resource("voikko-fi").stage do
      ENV.append_path "PATH", bin.to_s
      system "make", "vvfst"
      system "make", "vvfst-install", "DESTDIR=#{lib}/voikko"
      lib.install_symlink "voikko"
    end
  end

  test do
    assert_match "C: onkohan", pipe_output("#{bin}/voikkospell -m", "onkohan\n")
  end
end
