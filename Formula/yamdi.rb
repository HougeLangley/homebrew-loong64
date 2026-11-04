class Yamdi < Formula
  desc "Add metadata to Flash video"
  homepage "https://yamdi.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/yamdi/yamdi/1.9/yamdi-1.9.tar.gz"
  sha256 "4a6630f27f6c22bcd95982bf3357747d19f40bd98297a569e9c77468b756f715"
  license "BSD-3-Clause"


  # adobe flash player EOL 12/31/2020, https://www.adobe.com/products/flashplayer/end-of-life-alternative.html
  deprecate! date: "2025-03-21", because: :unmaintained
  disable! date: "2026-03-21", because: :unmaintained

  deny_network_access!

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "712560f99868a7b869a736e31eab8fc86722a1b7c7bd3e796b7d221a9e5ea813"
  end

  def install
    system ENV.cc, "yamdi.c", "-o", "yamdi", *ENV.cflags.to_s.split
    bin.install "yamdi"
    man1.install "man1/yamdi.1"
  end

  test do
    false
  end
end
