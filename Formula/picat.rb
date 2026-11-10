class Picat < Formula
  desc "Simple, and yet powerful, logic-based multi-paradigm programming language"
  homepage "https://picat-lang.org/"
  url "https://picat-lang.org/download/picat39_12_src.tar.gz"
  version "3.9.12"
  sha256 "05322b324ee904a62ca5b892d99c0f3abcf3e8f2bad1ce64732c03d70ef5fadc"
  license "MPL-2.0"

  livecheck do
    url "https://picat-lang.org/download.html"
    regex(/>\s*?Released\s+version\s+v?(\d+(?:[.#]\d+)+)[\s,]/im)
    strategy :page_match do |page, regex|
      page.scan(regex).map { |match| match[0].tr("#", ".") }
    end
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "58128c317a0a32e55de78e145fce7f93c51e5e06db3dd3b1370037ae352875e5"
  end

  def install
    # C23 makes false a keyword; upstream uses it only as legacy goto labels.
    %w[emu/espresso/cofactor.c emu/espresso/espresso_expand.c].each do |source|
      inreplace source, /\bfalse\b/, "false_label"
    end
    makefile = if OS.mac?
      "Makefile.mac64"
    else
      ENV.cxx11
      "Makefile.linux64"
    end
    # Espresso rules use ESPRESSO_FLAGS, not the main CFLAGS variable.
    inreplace "emu/common.mak", /^ESPRESSO_FLAGS =/, "ESPRESSO_FLAGS = -Wno-error=incompatible-pointer-types" unless OS.mac?
    system "make", "-C", "emu", "-f", makefile
    bin.install "emu/picat"
    prefix.install "lib" => "pi_lib"
    doc.install Dir["doc/*"]
    pkgshare.install "exs"
  end

  test do
    output = shell_output("#{bin}/picat #{pkgshare}/exs/euler/p1.pi").chomp
    assert_equal "Sum of all the multiples of 3 or 5 below 1000 is 233168", output
  end
end
