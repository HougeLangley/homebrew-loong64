class Mp3check < Formula
  desc "Tool to check mp3 files for consistency"
  homepage "https://code.google.com/archive/p/mp3check/"
  url "https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/mp3check/mp3check-0.8.7.tgz"
  sha256 "27d976ad8495671e9b9ce3c02e70cb834d962b6fdf1a7d437bb0e85454acdd0e"
  license "GPL-2.0-or-later"


  # Apply Debian patch to fix build with newer C++ standards
  patch do
    url "https://salsa.debian.org/reichel/mp3check/-/raw/2154e6fcb25189ab45c3ae6f787adc8526ad1377/debian/patches/fix_ftbfs_with_gcc_9"
    sha256 "00c90ab89e181cbbfe8ac54280acd17cfe6a1d3f4844685aca0426b9291f932f"
    type :unofficial
    resolves "https://bugs.debian.org/925782"
  end

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "375db89ab942d4fca75fa7164ece394939aac3b2163b23020398c1bb0af50a0b"
  end

  def install
    ENV.deparallelize
    # The makefile's install target is kinda iffy, but there's
    # only one file to install so it's easier to do it ourselves
    system "make"
    bin.install "mp3check"
  end

  test do
    assert version.to_s, shell_output("#{bin}/mp3check --version")
  end
end
