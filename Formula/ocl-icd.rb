class OclIcd < Formula
  desc "OpenCL ICD loader"
  homepage "https://github.com/OCL-dev/ocl-icd/"
  url "https://github.com/OCL-dev/ocl-icd/archive/refs/tags/v2.3.5.tar.gz"
  sha256 "cdd7984425fa92d37273eee4180b5f57b047eda6dd8fd623e58498f844b09b75"
  license "BSD-2-Clause"
  head "https://github.com/OCL-dev/ocl-icd.git", branch: "master"


  keg_only :shadowed_by_macos, "macOS provides OpenCL.framework"

  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "76298f28724612c66546e88f2077793496f279a0437de1cafe7f408ca4c27388"
  end

  depends_on "asciidoc" => :build
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "opencl-headers" => [:build, :test]
  depends_on "xmlto" => :build

  uses_from_macos "libxml2" => :build
  uses_from_macos "libxslt" => :build
  uses_from_macos "ruby" => :build

  conflicts_with "opencl-icd-loader", because: "both install `lib/libOpenCL.so` library"

  def install
    ENV["XML_CATALOG_FILES"] = etc/"xml/catalog"
    system "./bootstrap"
    system "./configure", *std_configure_args,
                          "--disable-silent-rules",
                          "--enable-custom-vendordir=#{etc}/OpenCL/vendors"
    system "make", "install"
    pkgshare.install "ocl_test.c"
  end

  def caveats
    s = "The default vendors directory is #{etc}/OpenCL/vendors\n"
    on_linux do
      s += <<~EOS
        No OpenCL implementation is pre-installed, so all dependents will require either
        installing a compatible formula or creating an ".icd" file mapping to an externally
        installed implementation. Any ".icd" files copied or symlinked into
        `#{etc}/OpenCL/vendors` will automatically be detected by `ocl-icd`.
        A portable OpenCL implementation is available via the `pocl` formula.
      EOS
    end
    s
  end

  test do
    cp pkgshare/"ocl_test.c", testpath
    system ENV.cc, "ocl_test.c", "-o", "test", "-I#{formula_opt_include("opencl-headers")}", "-L#{lib}", "-lOpenCL"
    ENV["OCL_ICD_VENDORS"] = testpath/"vendors"
    assert_equal "No platforms found!", shell_output("./test").chomp
  end
end
