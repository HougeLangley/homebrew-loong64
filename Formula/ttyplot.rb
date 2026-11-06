class Ttyplot < Formula
  desc "Realtime plotting utility for terminal with data input from stdin"
  homepage "https://github.com/tenox7/ttyplot"
  url "https://github.com/tenox7/ttyplot/archive/refs/tags/1.7.6.tar.gz"
  sha256 "37347a11899c5bfdb5f15fd69766fc5bdfdcb434aa82ae3e9dd10095c3266675"
  license "Apache-2.0"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "5ef039f6eac3f8744e8251273668875480a2d9d92f4b8016df9df877d029fec2"
  end

  livecheck do
    url :stable
    strategy :github_latest
  end


  depends_on "pkgconf" => :build
  uses_from_macos "ncurses"

  def install
    # --- 追加缺失库 ---
    ENV.append "LIBS", "-lncurses -ltinfo"
    ENV.append "LDFLAGS", "-lncurses -ltinfo"
    system "make", "LIBS=-lncurses -ltinfo"
    bin.install "ttyplot"
  end

  test do
    # `ttyplot` writes directly to the TTY, and doesn't stop even when stdin is closed.
    assert_match "unit displayed beside vertical bar", shell_output("#{bin}/ttyplot -h")
  end
end
