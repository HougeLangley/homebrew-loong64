class Libopusenc < Formula
  desc "Convenience library for creating .opus files"
  homepage "https://www.opus-codec.org/"
  url "https://ftp.osuosl.org/pub/xiph/releases/opus/libopusenc-0.3.tar.gz"
  mirror "https://archive.mozilla.org/pub/opus/libopusenc-0.3.tar.gz"
  sha256 "f616d3aff9b2034547894ccb8ab56c36cf1a4acb0d922c5d7119f97bbe58642c"
  license "BSD-3-Clause"

  livecheck do
    url "https://ftp.osuosl.org/pub/xiph/releases/opus/?C=M&O=D"
    regex(%r{href=(?:["']?|.*?/)libopusenc[._-]v?(\d+(?:\.\d+)+)\.t}i)
  end


  head do
    url "https://gitlab.xiph.org/xiph/libopusenc.git", branch: "master"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "7b52e72627da2a16b884f6c847607d552cdb9cab9604fd74c49b202b43b9e712"
  end

  depends_on "pkgconf" => :build
  depends_on "opus"

  def install
    system "./autogen.sh" if build.head?
    system "./configure", "--disable-silent-rules", *std_configure_args
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <opusenc.h>
      #include <assert.h>
      #include <stdint.h>
      #include <stdlib.h>
      int main() {
        OggOpusComments *comments = ope_comments_create();
        assert(comments);
        ope_comments_add(comments, "ARTIST", "Homebrew");
        ope_comments_add(comments, "TITLE", "Test Track");

        int error;
        OggOpusEnc *enc = ope_encoder_create_file("test.opus",
          comments, 48000, 2, 0, &error);;
        assert(error == OPE_OK);
        assert(enc);
        ope_comments_destroy(comments);

        int16_t *buffer = calloc(1920, 2*sizeof(*buffer));
        error = ope_encoder_write(enc, buffer, 1920*2*sizeof(*buffer));
        assert(error == OPE_OK);

        error = ope_encoder_drain(enc);
        assert(error == OPE_OK);
        ope_encoder_destroy(enc);

        return 0;
      }
    C
    system ENV.cc, "test.c", "-o", "test", "-Wall",
                   "-I#{formula_opt_include("opus")}/opus",
                   "-I#{include}/opus",
                   "-L#{lib}", "-lopusenc"
    system "./test"
  end
end
