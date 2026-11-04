class Bibutils < Formula
  desc "Bibliography conversion utilities"
  homepage "https://sourceforge.net/p/bibutils/home/Bibutils/"
  url "https://downloads.sourceforge.net/project/bibutils/bibutils_7.2_src.tgz"
  sha256 "6e028aef1e8a6b3e5acef098584a7bb68708f35cfe74011b341c11fea5e4b5c3"
  license "GPL-2.0-only"

  livecheck do
    url :stable
    regex(%r{url=.*?/bibutils[._-]v?(\d+(?:\.\d+)+)[._-]src\.t}i)
  end


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "ee6a5512ecf0156247cb6a245a09db81b600fadfe1afee2c6e62578d9dd65335"
  end

  def install
    system "./configure", "--install-dir", bin,
                          "--install-lib", lib
    system "make", "install", "CC=#{ENV.cc}"
  end

  test do
    (testpath/"test.bib").write <<~BIBTEX
      @article{Homebrew,
          title   = {Something},
          author  = {Someone},
          journal = {Something},
          volume  = {1},
          number  = {2},
          pages   = {3--4}
      }
    BIBTEX

    system bin/"bib2xml", "test.bib"
  end
end
