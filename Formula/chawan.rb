class Chawan < Formula
  desc "TUI web browser with CSS, inline image and JavaScript support"
  homepage "https://sr.ht/~bptato/chawan/"
  url "https://git.sr.ht/~bptato/chawan/archive/v0.5.1.tar.gz"
  sha256 "67a54f10acd2dcda6c62bca825ccaf228f94d04ba9dc85c9369930c58d12ec21"
  license "Unlicense"
  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "fdf378535c73487ab2e348298137ec1352e0f210abff7339f5ed218faa672de3"
  end

  head "https://git.sr.ht/~bptato/chawan", branch: "master"



  depends_on "nim" => :build
  depends_on "pkgconf" => :build

  depends_on "brotli"
  depends_on "libssh2"
  depends_on "openssl@4"

  uses_from_macos "curl"
  uses_from_macos "ncurses"

  deny_network_access!

  def install
    system "make"
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cha --version")

    (testpath/"index.html").write("<h1>Hello, Homebrew!</h1>")
    assert_equal "Hello, Homebrew!", shell_output("#{bin}/cha --dump #{testpath}/index.html").strip
  end
end
