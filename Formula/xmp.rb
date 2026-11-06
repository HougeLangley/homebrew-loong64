class Xmp < Formula
  desc "Command-line player for module music formats (MOD, S3M, IT, etc)"
  homepage "https://xmp.sourceforge.net/"
  url "https://github.com/libxmp/xmp-cli/releases/download/xmp-4.3.1/xmp-4.3.1.tar.gz"
  sha256 "cbfdab11233708c4de6ab965f64d96d4cb5b9d8e14d2d23df3b1b896386f870f"
  license "GPL-2.0-or-later"


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "f121e80821317b64e6f9f4dac1eada4271c626358c11b3fed20ea565042d6f20"
  end

  head do
    url "https://github.com/libxmp/xmp-cli.git", branch: "master"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool"  => :build
  end


  depends_on "pkgconf" => :build
  depends_on "libxmp"

  def install
    if build.head?
      system "glibtoolize"
      system "aclocal"
      system "autoconf"
      system "automake", "--add-missing"
    end

    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    assert_match "Fast Tracker II", shell_output("#{bin}/xmp --list-formats")
    assert_match "Extended Module Player #{version}", shell_output("#{bin}/xmp --version")
  end
end
