class Libotr < Formula
  desc "Off-The-Record (OTR) messaging library"
  homepage "https://otr.cypherpunks.ca/"
  url "https://otr.cypherpunks.ca/libotr-4.1.1.tar.gz"
  sha256 "8b3b182424251067a952fb4e6c7b95a21e644fbb27fbd5f8af2b2ed87ca419f5"
  license all_of: ["LGPL-2.1-only", "GPL-2.0-only"]
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "8cbef9d3fe3c4258495a6f35f399b7d769d704b472c6db6418e506cad77375d0"
  end

  compatibility_version 1

  livecheck do
    url :homepage
    regex(/href=.*?libotr[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  depends_on "pkgconf" => :test
  depends_on "libgcrypt"

  on_macos do
    depends_on "libgpg-error"
  end

  # Fix -flat_namespace being used on Big Sur and later.
  patch do
    file "Patches/libtool/configure-pre-0.4.2.418-big_sur.diff"
  end

  # Fix client.c:624:30: error: 'PF_UNIX' undeclared (first use in this function)
  patch do
    url "https://sources.debian.org/data/main/libo/libotr/4.1.1-5/debian/patches/0006-include-socket.h.patch"
    sha256 "cfda75f8c5bba2e735d2b4f1bb90f60b45fa1d554a97fff75cac467f7873ebde"
    type :unofficial
    resolves "https://bugs.debian.org/1009420"
  end

  deny_network_access!

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--mandir=#{man}", *std_configure_args
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <stdio.h>
      #include <stdlib.h>
      #include <libotr/proto.h>
      #include <libotr/b64.h>

      int main(void) {
        OTRL_INIT;
        char *encoded = otrl_base64_otr_encode((const unsigned char *)"Homebrew", 8);
        printf("%s\\n", encoded);
        free(encoded);
        return 0;
      }
    C

    pkgconf_flags = shell_output("pkgconf --cflags --libs libotr").chomp.split
    system ENV.cc, "test.c", "-o", "test", *pkgconf_flags
    assert_equal "?OTR:SG9tZWJyZXc=.", shell_output("./test").strip
  end
end
