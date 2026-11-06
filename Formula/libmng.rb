class Libmng < Formula
  desc "MNG/JNG reference library"
  homepage "https://sourceforge.net/projects/libmng/"
  url "https://downloads.sourceforge.net/project/libmng/libmng-devel/2.0.3/libmng-2.0.3.tar.gz"
  sha256 "cf112a1fb02f5b1c0fce5cab11ea8243852c139e669c44014125874b14b7dfaa"
  license "Zlib"
  revision 1
  compatibility_version 1


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "abcd73c69a5d1667e5f4592438450a2578a767ca95bf5d797b37826d22f02f8e"
  end

  depends_on "jpeg-turbo"
  depends_on "little-cms2"

  on_linux do
    depends_on "zlib-ng-compat"
  end

  resource "sample" do
    url "https://sembiance.com/fileFormatSamples/image/mng/abydos.mng"
    sha256 "4819310da1bbee591957185f55983798a0f8631c32c72b6029213c67071caf8d"
  end

  # Fix -flat_namespace being used on Big Sur and later.
  patch do
    file "Patches/libtool/configure-pre-0.4.2.418-big_sur.diff"
  end

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "./configure", "--build=loongarch64-unknown-linux-gnu", *std_configure_args, "--disable-silent-rules"
    system "make", "install"

    # Keep an example for test purposes, but fix header location to use system-level includes
    inreplace "contrib/gcc/mngtree/mngtree.c", "\"../../../libmng.h\"", "<libmng.h>"
    pkgshare.install "contrib/gcc/mngtree/mngtree.c"
  end

  test do
    system ENV.cc, pkgshare/"mngtree.c", "-DMNG_USE_SO",
           "-I#{formula_opt_include("jpeg-turbo")}",
           "-I#{include}", "-L#{lib}", "-lmng", "-o", "mngtree"

    resource("sample").stage do
      output = shell_output("#{testpath}/mngtree abydos.mng")
      assert_match "Starting dump of abydos.mng.", output
      assert_match "Done.", output
    end
  end
end
