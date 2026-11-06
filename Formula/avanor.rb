class Avanor < Formula
  desc "Quick-growing roguelike game with easy ADOM-like UI"
  homepage "https://avanor.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/avanor/avanor/0.5.8/avanor-0.5.8-src.tar.bz2"
  sha256 "8f55be83d985470b9a5220263fc87d0a0a6e2b60dbbc977c1c49347321379ef3"
  license "GPL-2.0-or-later"


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "0460aaff3a478d86865d46d4b119c0009e823d24dffbce3068be75e5be8a10f1"
  end

  uses_from_macos "ncurses"

  # Upstream fix for clang: https://sourceforge.net/p/avanor/code/133/
  patch :p0 do
    file "Patches/avanor/r133.diff"
    type :cherry_pick # from 0.5 branch
  end


  def install
    system "make", "DATA_DIR=#{pkgshare}/", "CC=#{ENV.cxx}", "LD=#{ENV.cxx}"
    bin.install "avanor"
    pkgshare.install "manual"
  end

  test do
    ENV["TERM"] = "xterm"
    assert_match "T h e  L a n d  o f  M y s t e r y", pipe_output(bin/"avanor", "\e", 0)
  end
end
