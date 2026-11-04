class Jpeginfo < Formula
  desc "Prints information and tests integrity of JPEG/JFIF files"
  homepage "https://www.kokkonen.net/tjko/projects.html"
  url "https://www.kokkonen.net/tjko/src/jpeginfo-1.7.1.tar.gz"
  sha256 "274f6be23fd089bd9e8715b67643a66ca2f63a503028bdea3e571228d50b669e"
  license "GPL-3.0-or-later"
  head "https://github.com/tjko/jpeginfo.git", branch: "main"

  livecheck do
    url :homepage
    regex(/href=.*?jpeginfo[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "9a95f143b8752a9bd71c43f61ca0c4398e4cc015971e35d6a0575e63f485ad74"
  end

  depends_on "autoconf" => :build
  depends_on "jpeg-turbo"

  def install
    ENV.deparallelize

    # The ./configure file inside the tarball is too old to work with Xcode 12, regenerate:
    system "autoconf", "--force"
    system "./configure", *std_configure_args
    system "make", "install"
  end

  test do
    system bin/"jpeginfo", "--help"
  end
end
