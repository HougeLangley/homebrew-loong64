class GssNtlmssp < Formula
  desc "NTLM authentication plugin for GSSAPI"
  homepage "https://github.com/gssapi/gss-ntlmssp"
  url "https://github.com/gssapi/gss-ntlmssp/releases/download/v1.3.2/gssntlmssp-1.3.2.tar.gz"
  sha256 "e5cc8d74e5f88cfe74622b14d1d28e85710dec898b754c2c78969f25147bbb55"
  license "ISC"
  revision 1
  head "https://github.com/gssapi/gss-ntlmssp.git", branch: "main"


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "b87e67565b1fc1bf16316ebdd9cfb3f2c1b6e718d20012b7bd17a216db99968b"
  end

  depends_on "gettext" => :build
  depends_on "pkgconf" => :build

  depends_on "krb5"
  depends_on "libunistring"
  depends_on :linux
  depends_on "openssl@4"
  depends_on "zlib-ng-compat"

  def install
    system "./configure", "--disable-static",
                          "--without-wbclient",
                          "--without-manpages",
                          *std_configure_args
    system "make", "install"

    # Install the GSSAPI mechanism configuration file
    (etc/"gss/mech.d").install "examples/mech.ntlmssp" => "ntlmssp.conf"
  end

  test do
    # Verify the mechanism config is installed with the correct library path
    conf = (etc/"gss/mech.d/ntlmssp.conf").read
    assert_match "gssntlmssp", conf
    assert_match lib.to_s, conf

    # Verify the shared library can be dlopened
    (testpath/"test.c").write <<~C
      #include <dlfcn.h>
      #include <stdio.h>
      int main() {
        void *handle = dlopen("#{lib}/gssntlmssp/gssntlmssp.so", RTLD_NOW);
        if (!handle) {
          fprintf(stderr, "dlopen: %s\\n", dlerror());
          return 1;
        }
        dlclose(handle);
        return 0;
      }
    C
    system ENV.cc, "test.c", "-o", "test", "-ldl"
    system "./test"
  end
end
