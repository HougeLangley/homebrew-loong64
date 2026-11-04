class Mairix < Formula
  desc "Email index and search tool"
  homepage "https://github.com/vandry/mairix"
  url "https://github.com/vandry/mairix/releases/download/0.24/mairix-0.24.tar.gz"
  sha256 "a0702e079c768b6fbe25687ebcbabe7965eb493d269a105998c7c1c2caef4a57"
  license "GPL-2.0-only"
  head "https://github.com/vandry/mairix.git", branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end


  uses_from_macos "bison" => :build
  uses_from_macos "flex" => :build

  on_linux do
    depends_on "zlib-ng-compat"
  end

  bottle do
    rebuild 2
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "45726cf4a95b82a271a4048f58d7b7d57a10ad4ef4225810bba05d921ebf2126"
  end

  def install
    ENV.deparallelize
    system "./configure", "--prefix=#{prefix}", "--mandir=#{man}"
    system "make"
    system "make", "install"
  end

  test do
    system bin/"mairix", "--version"
  end
end
