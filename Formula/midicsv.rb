class Midicsv < Formula
  desc "Convert MIDI audio files to human-readable CSV format"
  homepage "https://www.fourmilab.ch/webtools/midicsv/"
  url "https://www.fourmilab.ch/webtools/midicsv/midicsv-1.1.tar.gz"
  sha256 "7c5a749ab5c4ebac4bd7361df0af65892f380245be57c838e08ec6e4ac9870ef"
  license :public_domain

  livecheck do
    url :homepage
    regex(/href=.*?midicsv[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "af53044edcbc1f5ab13daab7e47ba892e32c6ee4a505b8a7a8c33cb6056525d2"
  end

  patch do
    url "https://homebrewloongarch64.site/brew-patches/midicsv.patch"
    sha256 "9023df8718aae94ecc4715b16c7402a8194c5828fb9c1bddf432b0a2d6b3be90"
  end

  def install
    system "make"
    system "make", "check"
    system "make", "install", "INSTALL_DEST=#{prefix}"
    share.install prefix/"man"
  end

  test do
    system bin/"midicsv", "-u"
  end
end
