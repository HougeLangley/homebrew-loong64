class Libtpms < Formula
  desc "Library for software emulation of a Trusted Platform Module"
  homepage "https://github.com/stefanberger/libtpms"
  url "https://github.com/stefanberger/libtpms/archive/refs/tags/v0.10.2.tar.gz"
  sha256 "edac03680f8a4a1c5c1d609a10e3f41e1a129e38ff5158f0c8deaedc719fb127"
  license "BSD-2-Clause"
  revision 1


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "2fad45276f613d266b37f543dc5a5e48b37280917ac1f1d776d2c76382ac2d37"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkgconf" => :build
  depends_on "openssl@4"

  def install
    system "./autogen.sh", "--with-openssl", "--with-tpm2", *std_configure_args
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <libtpms/tpm_library.h>

      int main()
      {
          TPM_RESULT res = TPMLIB_ChooseTPMVersion(TPMLIB_TPM_VERSION_2);
          if (res) {
              TPMLIB_Terminate();
              return 1;
          }
          return 0;
      }
    C
    system ENV.cc, "test.c", "-I#{include}", "-L#{lib}", "-ltpms", "-o", "test"
    system "./test"
  end
end
