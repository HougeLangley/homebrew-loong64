class Mussh < Formula
  desc "Multi-host SSH wrapper"
  homepage "https://mussh.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/mussh/mussh/1.0/mussh-1.0.tgz"
  sha256 "6ba883cfaacc3f54c2643e8790556ff7b17da73c9e0d4e18346a51791fedd267"
  license "GPL-1.0-or-later"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "370acf9b86727ead0ff53d4dab6d7488ade34bcf132c74e6e942a6c59f073d7c"
  end

  def install
    bin.install "mussh"
    man1.install "mussh.1"
  end

  test do
    system bin/"mussh", "--help"
  end
end
