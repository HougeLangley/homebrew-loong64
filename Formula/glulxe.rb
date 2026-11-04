class Glulxe < Formula
  desc "Portable VM like the Z-machine"
  homepage "https://www.eblong.com/zarf/glulx/"
  url "https://eblong.com/zarf/glulx/glulxe-061.tar.gz"
  version "0.6.1"
  sha256 "f81dc474d60d7d914fcde45844a4e1acafee50e13aebfcb563249cc56740769f"
  license "MIT"
  head "https://github.com/erkyrath/glulxe.git", branch: "master"

  livecheck do
    url :homepage
    regex(/href=.*?glulxe[._-]v?\d+(?:\.\d+)*\.t[^>]+?>\s*Glulxe\s+v?(\d+(?:\.\d+)+)\s*</im)
  end


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "3a0265da394765902e959f80c96a49cec195ae05069ea4d0f8f0704eab3f6ce8"
  end

  depends_on "glktermw" => :build

  uses_from_macos "ncurses"

  def install
    glk = Formula["glktermw"]
    inreplace "Makefile", "GLKINCLUDEDIR = ../cheapglk", "GLKINCLUDEDIR = #{glk.include}"
    inreplace "Makefile", "GLKLIBDIR = ../cheapglk", "GLKLIBDIR = #{glk.lib}"
    inreplace "Makefile", "Make.cheapglk", "Make.#{glk.name}"
    inreplace "Makefile", "-DOS_MAC", "-DOS_UNIX -DUNIX_RAND_GETRANDOM" if OS.linux?

    system "make"
    bin.install "glulxe"
  end

  test do
    assert pipe_output("#{bin}/glulxe -v").start_with? "GlkTerm, library version"
  end
end
