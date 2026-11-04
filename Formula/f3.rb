class F3 < Formula
  desc "Test various flash cards"
  homepage "https://fight-flash-fraud.readthedocs.io/en/latest/"
  url "https://github.com/AltraMayor/f3/archive/refs/tags/v10.0.tar.gz"
  sha256 "ce54275b7793f97391583ede33c1d87590901d8da20cce604b1f07a029aefc67"
  license "GPL-3.0-only"
  head "https://github.com/AltraMayor/f3.git", branch: "master"


  on_macos do
    depends_on "argp-standalone"
  end

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "32101795c4ccd00a561c185340947f574e1cd34d97e3b861114653fa6850903f"
  end

  def install
    args = []
    args << "ARGP=#{formula_opt_prefix("argp-standalone")}" if OS.mac?
    system "make", "all", *args
    bin.install %w[build/f3read build/f3write]
    man1.install "man/f3read.1"
    man1.install_symlink "f3read.1" => "f3write.1"
  end

  test do
    system bin/"f3read", testpath
  end
end
