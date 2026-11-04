class Libigloo < Formula
  desc "Generic C framework used and developed by the Icecast project"
  homepage "https://icecast.org/"
  url "https://downloads.xiph.org/releases/igloo/libigloo-0.9.5.tar.gz"
  sha256 "ea22e9119f7a2188810f99100c5155c6762d4595ae213b9ac29e69b4f0b87289"
  license "LGPL-2.0-or-later"

  livecheck do
    url "https://icecast.org/download/"
    regex(/href=.*?libigloo[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  head do
    url "https://gitlab.xiph.org/xiph/icecast-libigloo.git", branch: "master"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "7e481b3ffa9bb23f6d2bac83a6adbe7808b174133c5e1dd97d4a017875a6d7c2"
  end

  depends_on "pkgconf" => :build
  depends_on "rhash"

  def install
    system "./autogen.sh" if build.head?
    system "./configure", "--disable-silent-rules", *std_configure_args
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <stdlib.h>
      #include <igloo/tap.h>

      int main(void) {
        igloo_tap_init();
        igloo_tap_exit_on(igloo_TAP_EXIT_ON_FIN, NULL);
        igloo_tap_fin();
        return EXIT_FAILURE;
      }
    C
    system ENV.cc, "test.c", "-o", "test", "-L#{lib}", "-ligloo"
    system "./test"
  end
end
