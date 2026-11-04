class Screen < Formula
  desc "Terminal multiplexer with VT100/ANSI terminal emulation"
  homepage "https://www.gnu.org/software/screen/"
  url "https://ftpmirror.gnu.org/screen/screen-5.0.2.tar.gz"
  mirror "https://ftp.gnu.org/gnu/screen/screen-5.0.2.tar.gz"
  sha256 "ca9a2c7e240919bc7ac12124593ae4529bb4eb5f7349d8857829b7e3f0b3b332"
  license "GPL-3.0-or-later"
  head "https://git.savannah.gnu.org/git/screen.git", branch: "master"

  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "c0f843ff885c6d92e3c6bcc8142a688550ffb7f87bf099679d339258ad80b3c3"
  end



  depends_on "autoconf" => :build
  depends_on "automake" => :build

  uses_from_macos "libxcrypt"
  uses_from_macos "ncurses"

  on_linux do
    depends_on "linux-pam"
  end

  def install
    args = %W[
      --mandir=#{man}
      --infodir=#{info}
      --enable-pam
    ]

    system "./autogen.sh"

    # Exclude unrecognized options
    std_args = std_configure_args.reject { |s| s["--disable-debug"] || s["--disable-dependency-tracking"] }
    system "./configure", *args, *std_args
    system "make", "install"
  end

  test do
    system bin/"screen", "-h"
  end
end
