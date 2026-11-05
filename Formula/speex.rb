class Speex < Formula
  desc "Audio codec designed for speech"
  homepage "https://speex.org/"
  url "https://ftp.osuosl.org/pub/xiph/releases/speex/speex-1.2.1.tar.gz"
  mirror "https://mirror.csclub.uwaterloo.ca/xiph/releases/speex/speex-1.2.1.tar.gz"
  sha256 "4b44d4f2b38a370a2d98a78329fefc56a0cf93d1c1be70029217baae6628feea"
  license "BSD-3-Clause"

  livecheck do
    url "https://ftp.osuosl.org/pub/xiph/releases/speex/?C=M&O=D"
    regex(%r{href=(?:["']?|.*?/)speex[._-]v?(\d+(?:\.\d+)+)\.t}i)
  end


  head do
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "16d0b0d8d4d821ff23069df5b3bf5aee9d6c9a6e37d56de3eabf7efe5245b40e"
  end

    url "https://gitlab.xiph.org/xiph/speex.git", branch: "main"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  depends_on "pkgconf" => :build
  depends_on "libogg"

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "./autogen.sh" if build.head?
    system "./configure", "--build=loongarch64-unknown-linux-gnu", *std_configure_args
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <speex/speex.h>

      int main()
      {
          SpeexBits bits;
          void *enc_state;

          speex_bits_init(&bits);
          enc_state = speex_encoder_init(&speex_nb_mode);

          speex_bits_destroy(&bits);
          speex_encoder_destroy(enc_state);

          return 0;
      }
    C
    system ENV.cc, "test.c", "-L#{lib}", "-lspeex", "-o", "test"
    system "./test"
  end
end
