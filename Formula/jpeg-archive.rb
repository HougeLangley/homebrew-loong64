class JpegArchive < Formula
  desc "Utilities for archiving JPEGs for long term storage"
  homepage "https://github.com/danielgtaylor/jpeg-archive"
  url "https://github.com/danielgtaylor/jpeg-archive/archive/refs/tags/v2.2.0.tar.gz"
  sha256 "3da16a5abbddd925dee0379aa51d9fe0cba33da0b5703be27c13a2dda3d7ed75"
  license "MIT"
  revision 1


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "03a8a553b962a99a2690e87c7dc348283c65c2babb9b6efbeb162a8086350aec"
  end

  depends_on "mozjpeg"

  def install
    # Work around failure from GCC 10+ using default of `-fno-common`
    # multiple definition of `progname'; /tmp/ccMJX1Ay.o:(.bss+0x0): first defined here
    # multiple definition of `VERSION'; /tmp/ccMJX1Ay.o:(.bss+0x8): first defined here
    ENV.append_to_cflags "-fcommon" if OS.linux?

    system "make", "install", "PREFIX=#{prefix}", "MOZJPEG_PREFIX=#{formula_opt_prefix("mozjpeg")}", "LIBJPEG=-ljpeg"
  end

  test do
    system bin/"jpeg-recompress", test_fixtures("test.jpg"), "output.jpg"
  end
end
