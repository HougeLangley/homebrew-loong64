class Brogue < Formula
  desc "Roguelike game"
  homepage "https://sites.google.com/site/broguegame/"
  url "https://github.com/tmewett/BrogueCE/archive/refs/tags/v1.15.1.tar.gz"
  sha256 "2abc186c5327342cb9ad7e45d41096ab10797d5ba76dcac843824ac2a0bfb3ac"
  license "AGPL-3.0-or-later"
  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "fc0b8b239060e318086ec45e44732ebd129829d70f2044bed1c6ec92d37668f3"
  end

  head "https://github.com/tmewett/BrogueCE.git", branch: "master"



  depends_on "sdl2-compat"
  depends_on "sdl2_image"

  uses_from_macos "ncurses"

  def install
    # Use HOMEBREW_PREFIX path to get sdl2_image headers
    sdl_config = HOMEBREW_PREFIX/"bin/sdl2-config"

    system "make", "bin/brogue", "RELEASE=YES", "TERMINAL=YES", "DATADIR=#{libexec}", "SDL_CONFIG=#{sdl_config}"
    libexec.install "bin/brogue", "bin/keymap.txt", "bin/assets"

    # Use var directory to save highscores and replay files across upgrades
    (var/"brogue").mkpath
    (bin/"brogue").write <<~SHELL
      #!/bin/bash
      cd "#{var}/brogue" && exec "#{libexec}/brogue" "$@"
    SHELL
  end

  test do
    system bin/"brogue", "--version"
  end
end
