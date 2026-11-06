class Libxo < Formula
  desc "Allows an application to generate text, XML, JSON, and HTML output"
  homepage "https://juniper.github.io/libxo/libxo-manual.html"
  url "https://github.com/Juniper/libxo/releases/download/2.3.0/libxo-2.3.0.tar.gz"
  sha256 "f688acfbad07ba14826871437b0431bc0425d5732457013af5aff07236810f65"
  license "BSD-2-Clause"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "5f221d60493c236a001b70af4102f6fafa7ccd777d8ba999b5f4e7ec4c572bb3"
  end


  depends_on "byacc" => :build # the XPath parser needs byacc, not bison
  depends_on "libtool" => :build
  depends_on "gettext"

  # Only include `bsd/string.h` in the gettext test when configure found it
  patch do
    url "https://github.com/Juniper/libxo/commit/dc0017cb7cea89363a27721f6ab4593305167b61.patch?full_index=1"
    sha256 "37f0bf7e9e01a94f185dbd59af3785688eaf4267bf4b8a76d92b1cbe6cfc5413"
    type :unofficial
    resolves "https://github.com/Juniper/libxo/pull/119"
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

    # Nothing uses libcrypto, but finding it adds -lcrypto to every link
    ENV["ac_cv_lib_crypto_MD5_Init"] = "no"

    # configure only looks for gettext in /usr, /opt/local and /usr/local
    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--with-gettext=#{formula_opt_prefix("gettext")}",
                          "--prefix=#{prefix}"

    # glibc 2.38+ has `strlcpy` but does not declare it, so libxo leaves it
    # undefined in `libxo.so`; resolve it at load time (keeping the `-ldl` the
    # Makefile sets). Not needed on macOS, where `strlcpy` is in libc.
    if OS.linux?
      system "make", "install", "LDFLAGS=-ldl -Wl,--allow-shlib-undefined"
    else
      system "make", "install"
    end
  end

  test do
    (testpath/"test.c").write <<~C
      #include <libxo/xo.h>
      int main() {
        xo_set_flags(NULL, XOF_KEYS);
        return 0;
      }
    C
    system ENV.cc, "test.c", "-I#{include}", "-L#{lib}", "-lxo", "-o", "test"
    system "./test"
  end
end
