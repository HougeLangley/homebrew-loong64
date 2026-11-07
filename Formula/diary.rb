class Diary < Formula
  desc "Text-based journaling program"
  homepage "https://diary.p0c.ch"
  # Need to use git checkout since archive url is blocked
  url "https://git.in0rdr.ch/diary.git",
      tag:      "v0.16",
      revision: "e9c235ccbefdda9363c8d82f6e40c79df8e836f6"
  license "MIT"
  revision 1



  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "10d287adf8c2c464529b0aa5eceda2bae77724e1a2fc992d54f0c6a5ed8aad71"
  end

  depends_on "pkgconf" => :build

  uses_from_macos "curl"
  uses_from_macos "libxml2"
  uses_from_macos "ncurses"

  def install
    system "make"
    system "make", "CC=#{ENV.cc}", "PREFIX=#{prefix}", "install"
  end

  test do
    # Test version output matches the packaged version
    assert_match version.to_s, shell_output("#{bin}/diary -v")

    # There is only one configuration setting which is required to start the
    # application, the diary directory.
    #
    # Test DIARY_DIR environment variable
    assert_match "The directory 'na' does not exist", shell_output("DIARY_DIR=na #{bin}/diary 2>&1", 2)
    # Test diary dir option
    assert_match "The directory 'na' does not exist", shell_output("#{bin}/diary -d na 2>&1", 2)
    # Test missing diary dir option
    assert_match "The diary directory must be provided as (non-option) arg, " \
                 "`--dir` arg,\nor in the DIARY_DIR environment variable, " \
                 "see `diary --help` or DIARY(1)\n", shell_output("#{bin}/diary 2>&1", 1)
  end
end
