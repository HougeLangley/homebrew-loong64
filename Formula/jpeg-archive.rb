class JpegArchive < Formula
  desc "Utilities for archiving JPEGs for long term storage"
  homepage "https://github.com/danielgtaylor/jpeg-archive"
  url "https://github.com/danielgtaylor/jpeg-archive/archive/refs/tags/v2.2.0.tar.gz"
  sha256 "3da16a5abbddd925dee0379aa51d9fe0cba33da0b5703be27c13a2dda3d7ed75"
  license "MIT"
  revision 1




  depends_on "mozjpeg"

  def install
    # Work around failure from GCC 10+ using default of `-fno-common`
    # multiple definition of `progname'; /tmp/ccMJX1Ay.o:(.bss+0x0): first defined here
    # multiple definition of `VERSION'; /tmp/ccMJX1Ay.o:(.bss+0x8): first defined here
    ENV.append_to_cflags "-fcommon" if OS.linux?

    system "make", "install", "PREFIX=#{prefix}", "MOZJPEG_PREFIX=#{formula_opt_prefix("mozjpeg")}", "LIBJPEG=-ljpeg"

    # mozjpeg is keg-only and provides libjpeg.so.62 (SONAME LIBJPEG_6.2
    # symbols incl. jpeg_c_int_param_supported). The prefix-level lib dir
    # exposes other libjpeg builds with the same SONAME that shadow mozjpeg
    # at runtime through the relocated RUNPATH, causing "undefined symbol:
    # jpeg_c_int_param_supported, version LIBJPEG_6.2". Place mozjpeg's
    # library inside our keg so the first RUNPATH entry ($ORIGIN/../lib)
    # always resolves to it.
    mozjpeg = Formula["mozjpeg"]
    %w[libjpeg.so.62 libturbojpeg.so.0].each do |so|
      src = mozjpeg.opt_lib/so
      lib.install_symlink src => so if File.exist?(src)
    end
  end

  test do
    system bin/"jpeg-recompress", test_fixtures("test.jpg"), "output.jpg"
  end
end
