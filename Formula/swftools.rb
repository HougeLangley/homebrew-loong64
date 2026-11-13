class Swftools < Formula
  desc "SWF manipulation and generation tools"
  homepage "https://github.com/swftools/swftools"
  url "https://distfiles.macports.org/swftools/swftools-0.9.2.tar.gz"
  mirror "http://www.swftools.org/swftools-0.9.2.tar.gz"
  sha256 "bf6891bfc6bf535a1a99a485478f7896ebacbe3bbf545ba551298080a26f01f1"
  license "GPL-2.0-or-later"
  revision 1

  livecheck do
    url "https://raw.githubusercontent.com/swftools/swftools/HEAD/ChangeLog"
    regex(/^v?(\d+(?:\.\d+)+):/i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "14438c88af6fac098101ca52544efc623bb41a1f1c4e06eeb75654ea1c456651"
  end

  on_linux do
    depends_on "freetype"
    depends_on "lame"
    depends_on "zlib-ng-compat"
  end

  # Fixes a conftest for libfftwf.dylib that mistakenly calls fftw_malloc()
  # rather than fftwf_malloc().  Reported upstream to their mailing list:
  # https://lists.nongnu.org/archive/html/swftools-common/2012-04/msg00014.html
  # Patch is merged upstream.  Remove at swftools-0.9.3.
  # Also fix build on Linux by using correct flags for rm.
  # Linux fix sent to swftools mailing list:
  # https://lists.nongnu.org/archive/html/swftools-common/2022-06/msg00000.html
  patch :DATA

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "buildaux/#{cf}", "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}", "dist/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    # Work around failure from GCC 10+ using default of `-fno-common`
    # multiple definition of `voidclass'; ../lib/librfxswf.a(abc.o):(.bss+0x800): first defined here
    ENV.append_to_cflags "-fcommon" if OS.linux?
    if OS.linux?
      ENV.append_to_cflags "-I#{Formula["freetype"].opt_include}/freetype2"
      ENV.append_to_cflags "-I#{Formula["lame"].opt_include}/lame"
      # Generated lexers use YY_PROTO(...) as an empty argument list unless
      # this is set; C23 then treats yyunput's prototype as zero-argument.
      ENV.append_to_cflags "-DYY_USE_PROTOS=1"
      # The 2012 sources also contain other K&R-style empty parameter lists.
      ENV.append_to_cflags "-std=gnu17 -Wno-error=implicit-int -Wno-error=implicit-function-declaration"
      # These initializers put a namespace pointer into the union's leading
      # string_t* slot; name the intended member instead of suppressing the
      # incompatible-pointer diagnostic.
      inreplace "lib/as3/builtin.c",
                "{type: 8, &flash_utils_flash_proxy_constant_ns}",
                "{.type = 8, .ns = &flash_utils_flash_proxy_constant_ns}"
      inreplace "lib/as3/builtin.c",
                "{type: 8, &_AS3_constant_ns}",
                "{.type = 8, .ns = &_AS3_constant_ns}"
      # strrchr returns a pointer; these historical comparisons against 0
      # were accepted as warnings by old GCC but are now hard errors.
      inreplace "lib/pdf/xpdf/GlobalParams.cc",
                "if(pos1>=0)",
                "if(pos1 != NULL)"
      inreplace "lib/pdf/xpdf/GlobalParams.cc",
                "else if(pos2>=0)",
                "else if(pos2 != NULL)"
      # giflib 5 added an error-code out-parameter to these APIs.
      inreplace "src/gif2swf.c",
                "DGifOpenFileName(sname)",
                "DGifOpenFileName(sname, NULL)"
      inreplace "src/gif2swf.c",
                "DGifOpenFileName(s)",
                "DGifOpenFileName(s, NULL)"
      inreplace "src/gif2swf.c",
                "DGifCloseFile(gft)",
                "DGifCloseFile(gft, NULL)"
      # giflib 5 removed PrintGifError(); keep a useful diagnostic.
      inreplace "src/gif2swf.c",
                "PrintGifError();",
                'fprintf(stderr, "gif2swf: failed to read GIF data\n");'
    end

    args = []
    # Help old config scripts identify arm64 linux
    args << "--build=aarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    args << "--build=loongarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arch == :loongarch64

    system "./configure", *args, *std_configure_args
    system "make"
    system "make", "install"
  end

  test do
    system bin/"png2swf", "swftools_test.swf", test_fixtures("test.png")
  end
end

__END__
--- a/configure	2012-04-08 10:25:35.000000000 -0700
+++ b/configure	2012-04-09 17:42:10.000000000 -0700
@@ -6243,7 +6243,7 @@

     int main()
     {
-	char*data = fftw_malloc(sizeof(fftwf_complex)*600*800);
+	char*data = fftwf_malloc(sizeof(fftwf_complex)*600*800);
     	fftwf_plan plan = fftwf_plan_dft_2d(600, 800, (fftwf_complex*)data, (fftwf_complex*)data, FFTW_FORWARD, FFTW_ESTIMATE);
 	plan = fftwf_plan_dft_r2c_2d(600, 800, (float*)data, (fftwf_complex*)data, FFTW_ESTIMATE);
 	plan = fftwf_plan_dft_c2r_2d(600, 800, (fftwf_complex*)data, (float*)data, FFTW_ESTIMATE);
diff --git a/swfs/Makefile.in b/swfs/Makefile.in
index d7bc400..890b9bd 100644
--- a/swfs/Makefile.in
+++ b/swfs/Makefile.in
@@ -41,9 +41,9 @@ install:
 	$(INSTALL_DATA) ./PreLoaderTemplate.swf $(pkgdatadir)/swfs/PreLoaderTemplate.swf
 	$(INSTALL_DATA) ./tessel_loader.swf $(pkgdatadir)/swfs/tessel_loader.swf
 	$(INSTALL_DATA) ./swft_loader.swf $(pkgdatadir)/swfs/swft_loader.swf
-	rm -f $(pkgdatadir)/swfs/default_viewer.swf -o -L $(pkgdatadir)/swfs/default_viewer.swf
+	rm -f $(pkgdatadir)/swfs/default_viewer.swf
 	$(LN_S) $(pkgdatadir)/swfs/simple_viewer.swf $(pkgdatadir)/swfs/default_viewer.swf
-	rm -f $(pkgdatadir)/swfs/default_loader.swf -o -L $(pkgdatadir)/swfs/default_loader.swf
+	rm -f $(pkgdatadir)/swfs/default_loader.swf
 	$(LN_S) $(pkgdatadir)/swfs/tessel_loader.swf $(pkgdatadir)/swfs/default_loader.swf

 uninstall:
