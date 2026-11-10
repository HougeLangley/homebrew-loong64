class Gengetopt < Formula
  desc "Generate C code to parse command-line arguments via getopt_long"
  homepage "https://www.gnu.org/software/gengetopt/"
  url "https://ftpmirror.gnu.org/gengetopt/gengetopt-2.23.1.tar.xz"
  mirror "https://ftp.gnu.org/gnu/gengetopt/gengetopt-2.23.1.tar.xz"
  sha256 "3b9def48422bd45f78af95936200b7f9287369a3db76c4907c42fe10f4922ab6"
  license "GPL-3.0-or-later"

  on_system :linux, macos: :ventura_or_newer do
    depends_on "texinfo" => :build
  end

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--mandir=#{man}"

    ENV.deparallelize
    flags = "-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int " \
            "-Wno-error=implicit-function-declaration -Wno-error=int-conversion " \
            "-Wno-error=incompatible-pointer-types"
    system "make", "CFLAGS=#{flags}", "CXXFLAGS=#{flags}", "install"
  end

  test do
    ggo = <<~EOS
      package "homebrew"
      version "0.9.5"
      purpose "The missing package manager for macOS"

      option "verbose" v "be verbose"
    EOS

    pipe_output("#{bin}/gengetopt --file-name=test", ggo, 0)
    assert_path_exists testpath/"test.h"
    assert_path_exists testpath/"test.c"
    assert_match(/verbose_given/, File.read("test.h"))
  end
end
