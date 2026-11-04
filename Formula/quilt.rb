class Quilt < Formula
  desc "Work with series of patches"
  homepage "https://savannah.nongnu.org/projects/quilt"
  url "https://download.savannah.gnu.org/releases/quilt/quilt-0.69.tar.gz"
  sha256 "555ddffde22da3c86d1caf5a9c1fb8a152ac2b84730437bd39cc08849c9f4852"
  license "GPL-2.0-or-later"
  head "https://git.savannah.gnu.org/git/quilt.git", branch: "master"

  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "8e1e7cdbd3335945b5ab25ab7ff110c4806ab746e8472dbff8eb0af32f7158a7"
  end

  livecheck do
    url "https://download.savannah.gnu.org/releases/quilt/"
    regex(/href=.*?quilt[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end



  depends_on "coreutils"
  depends_on "gnu-sed"

  on_ventura :or_newer do
    depends_on "diffutils"
    depends_on "gpatch"
  end

  def install
    args = [
      "--prefix=#{prefix}",
      "--without-getopt",
    ]
    if OS.mac?
      args << "--with-sed=#{formula_opt_bin("gnu-sed")}/gsed"
      args << "--with-stat=/usr/bin/stat" # on macOS, quilt expects BSD stat
      if MacOS.version >= :ventura
        args << "--with-diff=#{formula_opt_bin("diffutils")}/diff"
        args << "--with-patch=#{formula_opt_bin("gpatch")}/gpatch"
      end
    else
      args << "--with-sed=#{formula_opt_bin("gnu-sed")}/sed"
    end
    system "./configure", *args

    system "make"
    system "make", "install", "emacsdir=#{elisp}"
  end

  test do
    (testpath/"patches").mkpath
    (testpath/"test.txt").write "Hello, World!"
    system bin/"quilt", "new", "test.patch"
    system bin/"quilt", "add", "test.txt"
    rm "test.txt"
    (testpath/"test.txt").write "Hi!"
    system bin/"quilt", "refresh"
    assert_match(/-Hello, World!/, File.read("patches/test.patch"))
    assert_match(/\+Hi!/, File.read("patches/test.patch"))
  end
end
