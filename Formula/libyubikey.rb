class Libyubikey < Formula
  desc "C library for manipulating Yubico one-time passwords"
  homepage "https://yubico.github.io/yubico-c/"
  url "https://developers.yubico.com/yubico-c/Releases/libyubikey-1.13.tar.gz"
  sha256 "04edd0eb09cb665a05d808c58e1985f25bb7c5254d2849f36a0658ffc51c3401"
  license "BSD-2-Clause"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "eee8209f249d259b293495b5fd02066ee11955893dac1584ef72f20cedc55e84"
  end

  livecheck do
    url "https://developers.yubico.com/yubico-c/Releases/"
    regex(/href=.*?libyubikey[._-]v?(\d+(?:\.\d+)+)\.t/i)
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

    system "./configure", "--build=loongarch64-unknown-linux-gnu", *std_configure_args
    system "make", "install"
  end

  test do
    aeskey = "ecde18dbe76fbd0c33330f1c354871db"
    token = "dcflcindvdbrblehecuitvjkjevvehjd"

    (testpath/"test.c").write <<~C
      #include <stdio.h>
      #include <yubikey.h>

      int main(void) {
        char encoded[9];
        yubikey_modhex_encode(encoded, "test", 4);
        printf("%s\\n", encoded);
        return 0;
      }
    C
    system ENV.cc, "test.c", "-I#{include}", "-L#{lib}", "-lyubikey", "-o", "test"
    assert_equal "ifhgieif", shell_output("./test").strip

    assert_equal "test", shell_output("#{bin}/modhex -d ifhgieif").strip
    assert_equal "b565716f", shell_output("#{bin}/modhex -d -h nghgibhv").strip
    output = shell_output("#{bin}/ykparse #{aeskey} #{token}")
    assert_match "modhex uid: jikdunvudhrr", output
    assert_match "crc check: ok", output
  end
end
