class Sshfs < Formula
  desc "File system client based on SSH File Transfer Protocol"
  homepage "https://github.com/libfuse/sshfs"
  url "https://github.com/libfuse/sshfs/archive/refs/tags/sshfs-3.7.6.tar.gz"
  sha256 "67a3e166a39b07708497ee0aee308547dba386053cf8d816b4ce8a9b3066a6ce"
  license any_of: ["LGPL-2.1-only", "GPL-2.0-only"]

  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "5190844e61d40d66bec6d2cdb70d47941ad7fc8567c8fb24598a5faa73cc99bb"
  end



  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkgconf" => :build
  depends_on "glib"
  depends_on "libfuse"
  depends_on :linux # on macOS, requires closed-source macFUSE

  def install
    system "meson", "setup", "build", *std_meson_args
    system "meson", "compile", "-C", "build", "--verbose"
    system "meson", "install", "-C", "build"
  end

  test do
    system bin/"sshfs", "--version"
  end
end
