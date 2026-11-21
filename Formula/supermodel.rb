class Supermodel < Formula
  desc "Sega Model 3 arcade emulator"
  homepage "https://github.com/trzy/Supermodel"
  url "https://github.com/trzy/Supermodel/archive/refs/tags/v0.3a-20261025-git-1481545.tar.gz"
  version "0.3a-20261025-git-1481545"
  sha256 "8d9161113d01dc7c301b406a51eeac7ca03fbd5c7daacee4d8cd31f673598969"
  license "GPL-3.0-or-later"
  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "ec175632ba81a0c87237606bc0f218634e06f50b5d8c03575fef93658e2cad5b"
  end

  head "https://github.com/trzy/Supermodel.git", branch: "master"



  depends_on "sdl2-compat"
  depends_on "sdl2_net"

  on_linux do
    depends_on "mesa"
    depends_on "mesa-glu"
    depends_on "zlib-ng-compat"
  end

  deny_network_access!

  def install
    # Not using Makefile.OSX as it uses prebuilt frameworks
    system "make", "-f", "Makefiles/Makefile.UNIX", "BIN_DIR=#{bin}"
  end

  test do
    system bin/"supermodel", "-print-games"
  end
end
