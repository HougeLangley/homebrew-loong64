class Cppunit < Formula
  desc "Unit testing framework for C++"
  homepage "https://wiki.freedesktop.org/www/Software/cppunit/"
  url "https://dev-www.libreoffice.org/src/cppunit-1.15.1.tar.gz"
  sha256 "89c5c6665337f56fd2db36bc3805a5619709d51fb136e51937072f63fcc717a7"
  license "LGPL-2.1-only"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "9dabfc46729b068e501f3c0567c97c92dc6e045b31f4907dc5c01e09a501240f"
  end

  livecheck do
    url "https://dev-www.libreoffice.org/src/"
    regex(/href=["']?cppunit[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  deny_network_access!

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "./configure", "--build=loongarch64-unknown-linux-gnu", *std_configure_args
    system "make", "install"
  end

  test do
    assert_match "Usage", shell_output("#{bin}/DllPlugInTester", 2)
  end
end
