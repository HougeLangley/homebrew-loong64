class Quickjs < Formula
  desc "Small and embeddable JavaScript engine"
  homepage "https://bellard.org/quickjs/"
  url "https://bellard.org/quickjs/quickjs-2026-06-04.tar.xz"
  sha256 "b376e839b322978313d929fd20663b11ba58b75df5a46c126dd19ea2fa70ad2a"
  license "MIT"

  livecheck do
    url :homepage
    regex(/href=.*?quickjs[._-]v?(\d+(?:[.-]\d+)+)\.t/i)
  end


  conflicts_with "quickjs-ng", because: "both install a `qjs` binary"

  deny_network_access!

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "2304605d5fdd8f2b14741ab43697a734b0e860c4c966da5e3f78b8d1a4cdee3a"
  end

  def install
    system "make", "install", "PREFIX=#{prefix}", "CONFIG_M32="
  end

  test do
    output = shell_output("#{bin}/qjs --eval 'const js=\"JS\"; console.log(`Q${js}${(7 + 35)}`);'").strip
    assert_match(/^QJS42/, output)

    test_file = testpath/"test.js"
    test_file.write "console.log('hello');"
    system bin/"qjsc", test_file
    assert_equal "hello", shell_output(testpath/"a.out").strip
  end
end
