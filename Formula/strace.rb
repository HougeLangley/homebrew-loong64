class Strace < Formula
  desc "Diagnostic, instructional, and debugging tool for the Linux kernel"
  homepage "https://strace.io/"
  url "https://github.com/strace/strace/releases/download/v6.12/strace-6.12.tar.xz"
  sha256 "c47da93be45b5785f1062fdd32b193ea4e907791346bc77ea2d3a15da5c8896b"
  license "LGPL-2.1-or-later"

  depends_on "linux-headers@5.15" => :build
  depends_on "pkgconf" => :build
  depends_on "libunwind"

  def install
    system "./configure",
           "--disable-dependency-tracking",
           "--prefix=#{prefix}",
           "--disable-silent-rules"
    system "make"
    system "make", "install"
  end

  test do
    system bin/"strace", "--version"
  end
end
