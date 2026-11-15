class Mfterm < Formula
  desc "Terminal for working with Mifare Classic 1-4k Tags"
  homepage "https://github.com/4ZM/mfterm"
  url "https://github.com/4ZM/mfterm/releases/download/v1.0.7/mfterm-1.0.7.tar.gz"
  sha256 "b6bb74a7ec1f12314dee42973eb5f458055b66b1b41316ae0c5380292b86b248"
  license "GPL-3.0-or-later"
  revision 3


  bottle do
    rebuild 2
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "8804da7a599786b91fb4384c6fd6c4afdde85a62bb398db1ddd6a4e1968dd7a0"
  end

  head do
    url "https://github.com/4ZM/mfterm.git", branch: "master"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
  end


  depends_on "libnfc"
  depends_on "openssl@4"

  uses_from_macos "bison" => :build
  uses_from_macos "flex" => :build

  on_linux do
    depends_on "readline"
  end

  def install
    ENV.prepend "CPPFLAGS", "-I#{formula_opt_include("openssl@4")}"
    ENV.prepend "LDFLAGS", "-L#{formula_opt_lib("openssl@4")}"

    if build.head?
      chmod 0755, "./autogen.sh"
      system "./autogen.sh"
    end
    system "./configure", "--disable-silent-rules", *std_configure_args
    system "make", "install"
  end

  test do
    system bin/"mfterm", "--version"
  end
end
