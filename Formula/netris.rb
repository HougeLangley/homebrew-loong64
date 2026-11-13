class Netris < Formula
  desc "Networked variant of tetris"
  homepage "https://packages.debian.org/sid/netris"
  url "https://deb.debian.org/debian/pool/main/n/netris/netris_0.52.orig.tar.gz"
  sha256 "8bc770ebb2c3ead1611ca7a1a2f3d833e169536c78d53b3fcf49381164ee9706"
  license "GPL-2.0-or-later"

  livecheck do
    skip "No longer developed or maintained"
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "1f94ac1bd82a75bd0f6ebab48c1a598b83868c15865a61a8797b5ffd68ce12b2"
  end

  uses_from_macos "ncurses"

  # Debian has been applying fixes and security patches, so let's re-use their work.
  # Also fixes case of "TERM=xterm-color256" which otherwise segfaults.
  patch do
    url "https://sources.debian.org/data/main/n/netris/0.52-9/debian/patches/01_multi-games-with-scoring"
    sha256 "5d5182afc06fbb6d011edfaa0c12e88425884019372f95faee563b760d03e556"
    type :unofficial
  end

  patch do
    url "https://sources.debian.org/data/main/n/netris/0.52-9/debian/patches/02_line-count-patch"
    sha256 "c31de57729cfde1ec72e49fd0ee1984cfffc179eb3d16b1268853e14e827b71f"
    type :unofficial
    resolves "https://bugs.debian.org/304224"
  end

  patch do
    url "https://sources.debian.org/data/main/n/netris/0.52-9/debian/patches/03_staircase-effect-fix"
    sha256 "df17bd23186c3d0379d298ac2e526ff40c7cdcebbe174c2bf2f08aa067abb4c7"
    type :unofficial
    resolves "https://bugs.debian.org/83039"
  end

  patch do
    url "https://sources.debian.org/data/main/n/netris/0.52-9/debian/patches/04_robot-close-fixup"
    sha256 "8c79a8925357b57b07d4afa8a2ef048528f4ca19e25851637fd6f20f93ea7ae4"
    type :unofficial
  end

  patch do
    url "https://sources.debian.org/data/main/n/netris/0.52-9/debian/patches/05_init-static-vars"
    sha256 "5b057390f6736c0d5c1d2b149c6550fb322358544641dc89d358c4c275a17724"
    type :unofficial
  end

  patch do
    url "https://sources.debian.org/data/main/n/netris/0.52-9/debian/patches/06_curses.c-include-term.h"
    sha256 "9f0b631dcfcf2114ea1c70a599df401aafa21fb73423fa98783d01ac9a0845dc"
    type :unofficial
    resolves "https://bugs.debian.org/325926"
  end

  patch do
    url "https://sources.debian.org/data/main/n/netris/0.52-9/debian/patches/07_curses.c-include-time.h"
    sha256 "b53bd8af4f09661ed9030baf52456595f3b4149966c2e3111c91305957a94a52"
    type :unofficial
    resolves "https://bugs.debian.org/345305"
  end

  patch do
    url "https://sources.debian.org/data/main/n/netris/0.52-9/debian/patches/08_various-fixes"
    sha256 "8c9f709c115d8acf4af04e6dd60d75f2c7ecda2f9708aca2a2848966ec6999db"
    type :unofficial
  end

  patch do
    url "https://sources.debian.org/data/main/n/netris/0.52-9/debian/patches/09_ipv6"
    sha256 "cf6c216cd4381a82945b441e2ad659120643126f52a89f745a9692fc708e8261"
    type :unofficial
  end

  patch do
    url "https://sources.debian.org/data/main/n/netris/0.52-9/debian/patches/10_fix-memory-leak"
    sha256 "380566f670b90585943a2f3c69fdb83bae04d0e62cc457bb8d7558f393f6b874"
    type :unofficial
    resolves "https://bugs.debian.org/590942"
  end

  def install
    # The curses probe uses an implicit-int main(), which C23 rejects; the
    # failed probe silently drops -lncurses and only fails at final link.
    inreplace "Configure",
              "echo 'main(){}' > test.c",
              "echo 'int main(void){return 0;}' > test.c"
    # The 1999 sources relied on implicit declarations for these POSIX APIs;
    # make the prototypes available to every translation unit.
    inreplace "netris.h",
              "#include <signal.h>",
              "#include <signal.h>\n#include <getopt.h>\n#include <time.h>"
    configure_args = [
      "--cextra",
      "-std=gnu17 -Wno-error=implicit-function-declaration -Wno-error=implicit-int",
    ]
    system "sh", "Configure", *configure_args
    system "make"
    bin.install "netris"
  end

  test do
    assert_match "Netris version #{version}", shell_output("#{bin}/netris -H 2>&1")
  end
end
