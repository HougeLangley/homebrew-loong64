class JpegArchive < Formula
  desc "Utilities for archiving JPEGs for long term storage"
  homepage "https://github.com/danielgtaylor/jpeg-archive"
  url "https://github.com/danielgtaylor/jpeg-archive/archive/refs/tags/v2.2.0.tar.gz"
  sha256 "3da16a5abbddd925dee0379aa51d9fe0cba33da0b5703be27c13a2dda3d7ed75"
  license "MIT"
  revision 1




  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "267d7e72fb25d1dfd0381c27fcf78a6a28ba2f1e4444b3590d597a3f9bb912f9"
  end

  depends_on "mozjpeg"

  # Our keg bundles libjpeg.so.62/libturbojpeg.so.0 shims into mozjpeg (see
  # install). Linking those SONAMEs into the prefix would collide with other
  # libjpeg builds, so keep the formula keg-only.
  keg_only "ships mozjpeg libjpeg SONAME shims that conflict in the prefix"

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
    # jpeg_c_int_param_supported, version LIBJPEG_6.2". Place RELATIVE
    # symlinks to mozjpeg's Cellar libraries inside our keg lib so the first
    # RUNPATH entry ($ORIGIN/../lib) always resolves to mozjpeg and the
    # bottle stays prefix-relocatable.
    mozjpeg = Formula["mozjpeg"]
    lib.mkpath
    %w[libjpeg.so.62 libturbojpeg.so.0].each do |so|
      src = mozjpeg.lib/so
      next unless File.exist?(src)
      dst = lib/so
      FileUtils.ln_sf(src.expand_path.relative_path_from(dst.expand_path.parent), dst)
    end
  end

  test do
    system bin/"jpeg-recompress", test_fixtures("test.jpg"), "output.jpg"
  end
end
