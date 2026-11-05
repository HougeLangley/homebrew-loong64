class Stow < Formula
  desc "Organize software neatly under a single directory tree (e.g. /usr/local)"
  homepage "https://www.gnu.org/software/stow/"
  url "https://ftpmirror.gnu.org/stow/stow-2.4.1.tar.gz"
  mirror "https://ftp.gnu.org/gnu/stow/stow-2.4.1.tar.gz"
  sha256 "2a671e75fc207303bfe86a9a7223169c7669df0a8108ebdf1a7fe8cd2b88780b"
  license "GPL-3.0-or-later"

  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "63b71ae93ca32ad20bcbdca6b82582f3d01f3ccdc4b532af74df1dea59dc166c"
  end


  uses_from_macos "perl"

  deny_network_access!


  def install
    system "./configure", *std_configure_args
    system "make", "install"
  end

  test do
    (testpath/"test").mkpath
    system bin/"stow", "-nvS", "test"
  end
end
