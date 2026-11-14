class TaskSpooler < Formula
  desc "Batch system to run tasks one after another"
  homepage "https://viric.name/soft/ts/"
  url "https://viric.name/soft/ts/ts-1.0.4.tar.gz"
  sha256 "b1ab3db52dca36af3699178b8d0e936a30107f8d5c86a974163c580823b01790"
  license "GPL-2.0-only"

  livecheck do
    url :homepage
    regex(/href=.*?ts[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  conflicts_with "moreutils", because: "both install a `ts` executable"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "55f105b99d95efca3989eafb2d7178d2a60b108899b363e5c44e5f903c86caa0"
  end

  def install
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    system bin/"ts", "-l"
    # ts -l starts a background server; stop it so the bottle step can rewrite bin/ts
    system bin/"ts", "-K"
  end
end
