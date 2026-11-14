class Tenyr < Formula
  desc "32-bit computing environment (including simulated CPU)"
  homepage "https://kulp.github.io/tenyr/"
  url "https://github.com/kulp/tenyr/archive/refs/tags/v0.9.9.tar.gz"
  sha256 "29010e3df8449e9210faf96ca5518d573af4ada4939fe1e7cfbc169fe9179224"
  license "MIT"
  bottle do
    rebuild 2
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "1c462e91d05656a83ff9ac931977bcc9a8b1d406ca4153211c86ad87193e6d3b"
  end

  head "https://github.com/kulp/tenyr.git", branch: "develop"



  depends_on "bison" => :build # tenyr requires bison >= 2.5

  depends_on "sdl2-compat"
  depends_on "sdl2_image"

  uses_from_macos "flex" => :build

  def install
    inreplace "src/devices/sdlvga.c", "SDL_image.h", "SDL2/SDL_image.h"
    inreplace "src/devices/sdlled.c", "SDL_image.h", "SDL2/SDL_image.h"

    # Work around failure from GCC 10+ using default of `-fno-common`
    # multiple definition of `...'; ....o:(.bss+0x0): first defined here
    ENV.append_to_cflags "-fcommon" if OS.linux?

    system "make", "BISON=#{formula_opt_bin("bison")}/bison",
                   "JIT=0", "BUILDDIR=build/homebrew"

    pkgshare.install "rsrc", "plugins"
    cd "build/homebrew" do
      bin.install "tsim", "tas", "tld"
      lib.install Dir[shared_library("*")]
    end
  end

  test do
    # sanity test assembler, linker and simulator
    (testpath/"part1").write "B <- 9\n"
    (testpath/"part2").write "C <- B * 3\n"

    system bin/"tas", "--output=a.to", "part1"
    system bin/"tas", "--output=b.to", "part2"
    system bin/"tld", "--output=test.texe", "a.to", "b.to"

    assert_match "C 0000001b", shell_output("#{bin}/tsim -vvvv test.texe 2>&1")
  end
end
