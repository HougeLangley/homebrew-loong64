class VtableDumper < Formula
  desc "List contents of virtual tables in a shared library"
  homepage "https://github.com/lvc/vtable-dumper"
  url "https://github.com/lvc/vtable-dumper/archive/refs/tags/1.2.tar.gz"
  sha256 "6993781b6a00936fc5f76dc0db4c410acb46b6d6e9836ddbe2e3c525c6dd1fd2"
  license "LGPL-2.1-or-later"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "d9936574d74162bc7276f84895118725fcfa0403aa547b63209e2dc8a81d6a1e"
  end

  depends_on "elfutils"
  depends_on :linux

  def install
    system "make", "prefix=#{prefix}", "install"
  end

  test do
    libstdcxx = Pathname.glob("/usr/**/libstdc++.so.6").first
    assert_match(/: \d+ entries/, shell_output("#{bin}/vtable-dumper #{libstdcxx}"))
  end
end
