class Nkf < Formula
  desc "Network Kanji code conversion Filter (NKF)"
  homepage "https://github.com/nurse/nkf"
  url "https://deb.debian.org/debian/pool/main/n/nkf/nkf_2.1.5.orig.tar.gz"
  sha256 "d1a7df435847a79f2f33a92388bca1d90d1b837b1b56523dcafc4695165bad44"
  license "Zlib"

  livecheck do
    url "https://deb.debian.org/debian/pool/main/n/nkf/"
    regex(/href=.*?nkf[._-]v?(\d+(?:\.\d+)+)\.orig\.t/i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "8a276503bc810b2b367393f888d8e5d580c5783aba8265483fe8e76664010219"
  end

  def install
    inreplace "Makefile", "$(prefix)/man", "$(prefix)/share/man"
    system "make", "CC=#{ENV.cc}"
    # Have to specify mkdir -p here since the intermediate directories
    # don't exist in an empty prefix
    system "make", "install", "prefix=#{prefix}", "MKDIR=mkdir -p"
  end

  test do
    system bin/"nkf", "--version"
  end
end
