class Cf < Formula
  desc "Filter to replace numeric timestamps with a formatted date time"
  homepage "https://ee.lbl.gov/"
  url "https://ee.lbl.gov/downloads/cf/cf-1.2.8.tar.gz"
  sha256 "52ce4302f7f9dd67227e5a3d09fc289127bf0ad256d24d8e1698733ea2e1fd48"
  license "BSD-3-Clause"

  livecheck do
    url "https://ee.lbl.gov/downloads/cf/"
    regex(/href=.*?cf[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  conflicts_with "cloudfoundry-cli", because: "both install `cf` binaries"

  deny_network_access!

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "fd7205446a65cffec32dd326b5101f8bc35636de0c118b975aef0035e4f33fa2"
  end

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}", "dist/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--prefix=#{prefix}"
    system "make"
    bin.mkpath
    man1.mkpath
    system "make", "install"
    system "make", "install-man"
  end

  test do
    assert_match "Jan 20 00:35:44", pipe_output("#{bin}/cf -u", "1074558944")
  end
end
