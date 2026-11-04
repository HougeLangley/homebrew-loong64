class Adplug < Formula
  desc "Free, hardware independent AdLib sound player library"
  homepage "https://adplug.github.io"
  url "https://github.com/adplug/adplug/releases/download/adplug-2.4/adplug-2.4.tar.bz2"
  sha256 "de18463bf7c0cb639a3228ad47e69eb7f78a5a197802d325f3a5ed7e1c56d57f"
  license "LGPL-2.1-or-later"


  head do
    url "https://github.com/adplug/adplug.git", branch: "master"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "49641483f57a7b2828635929bd3fe60665dec06a4cf5f6f051b21f0724af663f"
  end

  depends_on "pkgconf" => :build
  depends_on "libbinio"

  on_system :linux, macos: :ventura_or_newer do
    depends_on "texinfo" => :build
  end

  resource "ksms", :test do
    url "https://advsys.net/ken/ksmsongs.zip"
    sha256 "2af9bfc390f545bc7f51b834e46eb0b989833b11058e812200d485a5591c5877"
  end

  allow_network_access! :test

  def install
    # Workaround for arm64 linux, issue ref: https://github.com/adplug/adplug/issues/246
    ENV.append_to_cflags "-fsigned-char" if OS.linux? && Hardware::CPU.arm?

    system "autoreconf", "--force", "--install", "--verbose" if build.head?
    system "./configure", *std_configure_args
    system "make", "install"
  end

  test do
    resource("ksms").stage do
      (testpath/".adplug").mkpath
      system bin/"adplugdb", "-v", "add", "JAZZSONG.KSM"
    end
  end
end
