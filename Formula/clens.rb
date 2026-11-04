class Clens < Formula
  desc "Library to help port code from OpenBSD to other operating systems"
  homepage "https://github.com/conformal/clens"
  url "https://github.com/conformal/clens/archive/refs/tags/CLENS_0_7_0.tar.gz"
  sha256 "0cc18155c2c98077cb90f07f6ad8334314606c4be0b6ffc13d6996171c7dc09d"
  license "ISC"

  livecheck do
    url :stable
    regex(/^CLENS[._-]v?(\d+(?:[._]\d+)+)$/i)
    strategy :git do |tags, regex|
      tags.filter_map { |tag| tag[regex, 1]&.tr("_", ".") }
    end
  end


  on_linux do
    depends_on "libbsd"
  end

  patch do
    url "https://github.com/conformal/clens/commit/83648cc9027d9f76a1bc79ddddcbed1349b9d5cd.patch?full_index=1"
    sha256 "c70833eff6f98eab6166e9c341bb444eae542617f4937a29514fe5c6bbd3d8b0"
    type :backport
    resolves "https://github.com/conformal/clens/pull/3"
  end

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "8760e0eec7a16b967ac37c6e6a2431d47fed9294c7d82032e4c55620a90568d7"
  end

  def install
    ENV.deparallelize
    system "make", "all", "install", "LOCALBASE=#{prefix}"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <stdio.h>
      #include <clens.h>

      int main(void) {
        char buf[FMT_SCALED_STRSIZE];
        if (fmt_scaled(1536, buf) != 0) return 1;
        printf("%s %s\\n", clens_verstring(), buf);
        return 0;
      }
    C
    system ENV.cc, "test.c", "-I#{include}/clens", "-L#{lib}", "-lclens", "-o", "test"
    assert_equal "#{version} 1.5K", shell_output("./test").strip
  end
end
