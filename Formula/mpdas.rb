class Mpdas < Formula
  desc "C++ client to submit tracks to audioscrobbler"
  homepage "https://www.50hz.ws/mpdas/"
  url "https://www.50hz.ws/mpdas/mpdas-0.4.5.tar.gz"
  sha256 "c9103d7b897e76cd11a669e1c062d74cb73574efc7ba87de3b04304464e8a9ca"
  license "BSD-3-Clause"
  head "https://github.com/hrkfdn/mpdas.git", branch: "master"

  livecheck do
    url :homepage
    regex(/href=.*?mpdas[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  bottle do
    rebuild 2
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "9eea529c6736a7e7838f0715a75d6b09a4fa4f5c9ec6c7195f5ab8f2e18f6dff"
  end

  depends_on "pkgconf" => :build
  depends_on "libmpdclient"

  uses_from_macos "curl"

  def install
    system "make", "PREFIX=#{prefix}", "MANPREFIX=#{man1}", "CONFIG=#{etc}", "install"
    etc.install "mpdasrc.example"
  end

  service do
    run opt_bin/"mpdas"
    keep_alive true
    working_dir HOMEBREW_PREFIX
  end

  test do
    system bin/"mpdas", "-v"
  end
end
