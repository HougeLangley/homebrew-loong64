class Paperjam < Formula
  desc "Program for transforming PDF files"
  homepage "https://mj.ucw.cz/sw/paperjam/"
  url "https://mj.ucw.cz/download/linux/paperjam-1.2.2.tar.gz"
  sha256 "a281912d00a935f490ce20873e87b82d5203bb6180326be1bec60184acab30fc"
  license "GPL-2.0-or-later"

  livecheck do
    url :homepage
    regex(/href=.*?paperjam[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "819fc14c5725c3133e412cc0116639ece3434ed718682790df6c6878daed38db"
  end

  depends_on "asciidoc" => :build
  depends_on "docbook-xsl" => :build
  depends_on "libpaper"
  depends_on "qpdf"

  uses_from_macos "libxslt"

  def install
    ENV["XML_CATALOG_FILES"] = "#{etc}/xml/catalog"
    ENV.append "LDLIBS", "-liconv" if OS.mac?
    system "make"
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    system bin/"paperjam", "modulo(2) { 1, 2: rotate(180) }", test_fixtures("test.pdf"), "output.pdf"
    assert_path_exists testpath/"output.pdf"
  end
end
