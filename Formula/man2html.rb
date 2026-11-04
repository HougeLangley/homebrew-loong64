class Man2html < Formula
  desc "Convert nroff man pages to HTML"
  homepage "https://savannah.nongnu.org/projects/man2html/"
  url "https://www.mhonarc.org/release/misc/man2html3.0.1.tar.gz"
  mirror "https://distfiles.macports.org/man2html/man2html3.0.1.tar.gz"
  sha256 "a3dd7fdd80785c14c2f5fa54a59bf93ca5f86f026612f68770a0507a3d4e5a29"
  license "GPL-2.0-or-later"

  livecheck do
    url "https://www.mhonarc.org/release/misc/"
    regex(/href=.*?man2html[._-]?v?(\d+(?:\.\d+)+)\.t/i)
  end


  deny_network_access!

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "27442305f9f363118f071e2d8d4b0d8c5604de1bc80bbb1d6fad17cdbd65bfd7"
  end

  def install
    bin.mkpath
    man1.mkpath
    system "/usr/bin/perl", "install.me", "-batch",
                            "-binpath", bin,
                            "-manpath", man
  end

  test do
    pipe_output(bin/"man2html", (man1/"man2html.1").read, 0)
  end
end
