class Xorriso < Formula
  desc "ISO9660+RR manipulation tool"
  homepage "https://www.gnu.org/software/xorriso/"
  url "https://ftpmirror.gnu.org/xorriso/xorriso-1.5.8.pl02.tar.gz"
  mirror "https://ftp.gnu.org/gnu/xorriso/xorriso-1.5.8.pl02.tar.gz"
  version "1.5.8.pl02"
  sha256 "b1455ecafbf0692ddafe1d71002a96f2ce2d77f4deae602678261ce033f97bc8"
  license "GPL-2.0-or-later"

  livecheck do
    url :stable
    regex(/href=.*?xorriso[._-]v?(\d+(?:\.\d+)+(?:\.pl\d+)?)\.t/i)
  end


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "c90b817049ecbe92a92abd60a9b50adafdf75fe489350ef170923d7dd100b950"
  end

  on_linux do
    depends_on "acl"
    depends_on "zlib-ng-compat"
  end


  def install
    system "./configure", "--disable-silent-rules", *std_configure_args
    system "make"

    # `make install` has to be deparallelized due to the following error:
    #   mkdir: /usr/local/Cellar/xorriso/1.4.2/bin: File exists
    #   make[1]: *** [install-binPROGRAMS] Error 1
    # Reported 14 Jun 2016: https://lists.gnu.org/archive/html/bug-xorriso/2016-06/msg00003.html
    ENV.deparallelize { system "make", "install" }
  end

  test do
    assert_match "List of xorriso extra features", shell_output("#{bin}/xorriso -list_extras")
    assert_match version.to_s, shell_output("#{bin}/xorriso -version")
  end
end
