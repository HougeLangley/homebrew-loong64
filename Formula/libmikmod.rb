class Libmikmod < Formula
  desc "Portable sound library"
  homepage "https://mikmod.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/mikmod/libmikmod/3.3.15/libmikmod-3.3.15.tar.gz"
  sha256 "dc27b338154b8f88dc9e6317196d42c6abc13bf63c4e055257a18d4e38e1afa2"
  license "LGPL-2.0-or-later"

  livecheck do
    url :stable
    regex(%r{url=.*?/libmikmod[._-](\d+(?:\.\d+)+)\.t}i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "6ecf4ec8551023e3da57b44bcaf17972937538595e0769068bda0b2d44470758"
  end

  def install
    mkdir "macbuild" do
      # macOS has CoreAudio, but ALSA, SAM9407 and ULTRA are not supported
      system "../configure", "--prefix=#{prefix}", "--disable-alsa",
                             "--disable-sam9407", "--disable-ultra"
      system "make", "install"
    end
  end

  test do
    system bin/"libmikmod-config", "--version"
  end
end
