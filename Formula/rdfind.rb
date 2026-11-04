class Rdfind < Formula
  desc "Find duplicate files based on content (NOT file names)"
  homepage "https://rdfind.pauldreik.se/"
  url "https://rdfind.pauldreik.se/rdfind-1.8.0.tar.gz"
  sha256 "0a2d0d32002cc2dc0134ee7b649bcc811ecfb2f8d9f672aa476a851152e7af35"
  license "GPL-2.0-or-later"
  revision 1

  livecheck do
    url :homepage
    regex(/href=.*?rdfind[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "a2554f8a2c2ed372fa57e53a464ec29406e389ede25225453355d896d2aa9cf9"
  end

  depends_on "nettle"

  def install
    ENV.append "CXXFLAGS", "-std=c++17"

    system "./configure", *std_configure_args
    system "make", "install"
  end

  test do
    mkdir "folder"
    (testpath/"folder/file1").write("foo")
    (testpath/"folder/file2").write("bar")
    (testpath/"folder/file3").write("foo")
    system bin/"rdfind", "-deleteduplicates", "true", "folder"
    assert_path_exists testpath/"folder/file1"
    assert_path_exists testpath/"folder/file2"
    refute_path_exists testpath/"folder/file3"
  end
end
