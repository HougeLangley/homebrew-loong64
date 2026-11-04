class Patchutils < Formula
  desc "Small collection of programs that operate on patch files"
  homepage "https://cyberelk.net/tim/software/patchutils/"
  url "https://github.com/twaugh/patchutils/releases/download/0.4.5/patchutils-0.4.5.tar.xz"
  sha256 "8386a35a4d2d3cbc28fdcc93c5be007c382c78e3ee079070139f0d822e013325"
  license all_of: ["GPL-2.0-or-later", "LGPL-2.1-or-later"]


  head do
    url "https://github.com/twaugh/patchutils.git", branch: "master"
    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "docbook" => :build
  end

  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "66249341123020f004cde00b1e4c44d57418f5d3b86c5411ffc600b4fd346efc"
  end

  depends_on "xmlto" => :build

  def install
    ENV["XML_CATALOG_FILES"] = "#{etc}/xml/catalog"
    system "./bootstrap" if build.head?
    system "./configure", *std_configure_args
    system "make", "install"
  end

  test do
    assert_match %r{a/libexec/NOOP}, shell_output("#{bin}/lsdiff #{test_fixtures("test.diff")}")
  end
end
