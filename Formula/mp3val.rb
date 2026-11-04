class Mp3val < Formula
  desc "Program for MPEG audio stream validation"
  homepage "https://mp3val.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/mp3val/mp3val/mp3val%200.1.8/mp3val-0.1.8-src.tar.gz"
  sha256 "95a16efe3c352bb31d23d68ee5cb8bb8ebd9868d3dcf0d84c96864f80c31c39f"
  license "GPL-2.0-or-later"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "27c8d4740db9d1a71f08ec541ee1daf77fe5eac9f801ee66a0aaef9d6c4e9dc9"
  end

  def install
    # Apply this upstream commit to fix build on Linux:
    # https://sourceforge.net/p/mp3val/subversion/95/
    # Remove with next release.
    inreplace "crossapi.cpp",
              "od=open(szNewName,O_WRONLY|O_CREAT|O_TRUNC);",
              "od=open(szNewName,O_WRONLY|O_CREAT|O_TRUNC, S_IRUSR|S_IWUSR);"
    system "make", "-f", "Makefile.gcc"
    bin.install "mp3val.exe" => "mp3val"
  end

  test do
    mp3 = test_fixtures("test.mp3")
    assert_match(/Done!$/, shell_output("#{bin}/mp3val -f #{mp3}"))
  end
end
