class Rpm2cpio < Formula
  desc "Tool to convert RPM package to CPIO archive"
  homepage "https://svnweb.freebsd.org/ports/head/archivers/rpm2cpio/"
  url "https://svnweb.freebsd.org/ports/head/archivers/rpm2cpio/files/rpm2cpio?revision=408590&view=co"
  version "1.4"
  sha256 "2841bacdadde2a9225ca387c52259d6007762815468f621253ebb537d6636a00"
  license "BSD-2-Clause"

  livecheck do
    url "https://svnweb.freebsd.org/ports/head/archivers/rpm2cpio/Makefile?view=co"
    regex(/^PORTVERSION=\s*?v?(\d+(?:\.\d+)+)$/i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "2ea45a20f6ea8d8da11f7acdd02451ca0222e5cd0ab25d198e293c23f87faaae"
  end

  depends_on "libarchive"
  depends_on "xz"

  conflicts_with "rpm", because: "both install `rpm2cpio` binaries"

  resource "homebrew-testdata", :test do
    url "https://github.com/github/gh-ost/releases/download/v1.1.7/gh-ost-1.1.7-1.x86_64.rpm"
    sha256 "9e7c91d07ccae51c653252b8c58c148032f3785223bfa8e531eba81aa912b71a"
  end

  def install
    tar = OS.mac? ? "tar" : "bsdtar"
    inreplace "rpm2cpio", "tar", formula_opt_bin("libarchive")/tar
    bin.install "rpm2cpio"
  end

  test do
    testpath.install resource "homebrew-testdata"
    system bin/"rpm2cpio", "gh-ost-1.1.7-1.x86_64.rpm"
  end
end
