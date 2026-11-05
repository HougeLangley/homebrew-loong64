class Vcprompt < Formula
  desc "Provide version control info in shell prompts"
  homepage "https://github.com/powerman/vcprompt"
  url "https://github.com/powerman/vcprompt/archive/refs/tags/v1.3.0.tar.gz"
  sha256 "3db5ebad2e333d43b464b665c8d43b35156b0f144052f10c340a5c5007a6874d"
  license "GPL-2.0-or-later"

  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "cb6117a4a13be487944c77c498da100e4e2ee3e8b1eb9786292b2456e95dc53f"
  end



  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "sqlite"

  def install
    system "autoreconf", "--force", "--install", "--verbose"
    system "./configure", *std_configure_args
    system "make", "PREFIX=#{prefix}",
                   "MANDIR=#{man1}",
                   "install"
  end

  test do
    system bin/"vcprompt"
  end
end
