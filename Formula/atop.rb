class Atop < Formula
  desc "Advanced system and process monitor for Linux using process events"
  homepage "https://www.atoptool.nl"
  url "https://github.com/Atoptool/atop/archive/refs/tags/v2.13.0.tar.gz"
  sha256 "5ee38c93afd64767a09a06698a0e90bfc390189a5058d245878a559d476d8572"
  license "GPL-2.0-or-later"
  head "https://github.com/Atoptool/atop.git", branch: "master"


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "37778091de5bbfb41155ebc1ee52c8821461015762c06608177f16699955ea88"
  end

  depends_on "pkgconf" => :build
  depends_on "glib"
  depends_on :linux
  depends_on "ncurses"
  depends_on "zlib-ng-compat"

  def install
    inreplace "version.h", /"$/, "-#{Utils.git_short_head}\"", global: false if build.head?
    # As this project does not use configure, we have to configure manually:
    ENV["BINPATH"] = bin.to_s
    ENV["SBINPATH"] = bin.to_s
    ENV["MAN1PATH"] = man1.to_s
    ENV["MAN5PATH"] = man5.to_s
    ENV["MAN8PATH"] = man8.to_s
    ENV["DEFPATH"] = "prev"
    ENV["LOGPATH"] = "prev"
    # It would try to install some files suid, which is not good for users:
    inreplace "Makefile", "chmod", "true"
    # RPM and Debian packages do not use the Makefile for users, but it ensures we forget nothing:
    system "make", "-e", "genericinstall"
  end

  test do
    assert_match "Version:", shell_output("#{bin}/atop -V")
    system bin/"atop", "1", "1"
    system bin/"atop", "-w", "atop.raw", "1", "1"
    system bin/"atop", "-r", "atop.raw", "-PCPU,DSK"
  end
end
