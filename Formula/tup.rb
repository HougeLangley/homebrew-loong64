class Tup < Formula
  desc "File-based build system"
  homepage "https://gittup.org/tup/"
  url "https://github.com/gittup/tup/archive/refs/tags/v0.8.tar.gz"
  sha256 "45ca35c4c1d140f3faaab7fabf9d68fd9c21074af2af9a720cff4b27cab47d07"
  license "GPL-2.0-only"
  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "6b9ceea195063d0a28d8cc17e0b1d5065e8936fabce2dbbe6f0d0ec49fb46fd2"
  end

  revision 1
  head "https://github.com/gittup/tup.git", branch: "master"



  depends_on "pkgconf" => :build
  depends_on "libfuse"
  depends_on :linux # on macOS, requires closed-source macFUSE

  def install
    ENV["TUP_LABEL"] = version
    system "./build.sh"
    bin.install "build/tup"
    man1.install "tup.1"
    doc.install (buildpath/"docs").children
    pkgshare.install "contrib/syntax"
  end

  test do
    system bin/"tup", "-v"
  end
end
