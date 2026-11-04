class Ctpv < Formula
  desc "Image previews for lf file manager"
  homepage "https://www.nikitaivanov.com/man1/ctpv"
  url "https://github.com/NikitaIvanovV/ctpv/archive/refs/tags/v1.1.tar.gz"
  sha256 "29e458fbc822e960f052b47a1550cb149c28768615cc2dddf21facc5c86f7463"
  license "MIT"
  revision 1


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "ad1b26ec88af523e6f83d67e0a76169f25dc22b49a62e88b4f5e13f44b6f016c"
  end

  depends_on "libmagic"
  depends_on "openssl@4"

  fails_with :clang do
    build 1300
    cause "Requires Clang 14 or later"
  end

  def install
    # Workaround for arm64 linux, issue ref: https://github.com/NikitaIvanovV/ctpv/issues/101
    ENV.append_to_cflags "-fsigned-char" if OS.linux? && Hardware::CPU.arm?

    system "make", "PREFIX=#{prefix}", "install"
  end

  test do
    file = test_fixtures("test.diff")
    output = shell_output("#{bin}/ctpv #{file}").gsub(/\e\[[\d;]*m/, "")
    assert_match shell_output("cat #{file}"), output
  end
end
