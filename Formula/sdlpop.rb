class Sdlpop < Formula
  desc "Open-source port of Prince of Persia"
  homepage "https://github.com/NagyD/SDLPoP"
  url "https://github.com/NagyD/SDLPoP/archive/refs/tags/v1.23.tar.gz"
  sha256 "41a9aa64b4e8d0a9d7a84ffced48f74f9528d81adbffc08593ecf84776c5d77a"
  license "GPL-3.0-or-later"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end



  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "16b1617ab6ce8bfc34e84f00a2fcc5cebd4cdc1b9f2c617fea3f8c9c62abadf7"
  end

  depends_on "pkgconf" => :build
  depends_on "sdl2-compat"
  depends_on "sdl2_image"

  def install
    system "make", "-C", "src"
    doc.install Dir["doc/*"]
    libexec.install "data"
    libexec.install "prince"

    # Use var directory to keep save and replay files
    pkgvar = var/"sdlpop"
    pkgvar.install "SDLPoP.ini" unless (pkgvar/"SDLPoP.ini").exist?

    (bin/"prince").write <<~BASH
      #!/bin/bash
      cd "#{pkgvar}" && exec "#{libexec}/prince" $@
    BASH
  end

  def caveats
    <<~EOS
      Save and replay files are stored in the following directory:
        #{var}/sdlpop
    EOS
  end

  test do
    assert_equal "See README.md", shell_output("#{bin}/prince --help").chomp
  end
end
