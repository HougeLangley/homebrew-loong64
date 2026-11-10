class Dvanalyzer < Formula
  desc "Quality control tool for examining tape-to-file DV streams"
  homepage "https://mediaarea.net/DVAnalyzer"
  url "https://mediaarea.net/download/binary/dvanalyzer/1.4.2/DVAnalyzer_CLI_1.4.2_GNU_FromSource.tar.bz2"
  sha256 "d2f3fdd98574f7db648708e1e46b0e2fa5f9e6e12ca14d2dfaa77c13c165914c"
  license all_of: ["BSD-2-Clause", "GPL-3.0-or-later", "Zlib"]

  livecheck do
    url "https://mediaarea.net/DVAnalyzer/Download/Source"
    regex(/href=.*?dvanalyzer[._-]?(\d+(?:\.\d+)+)\.t/i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "8efaa63a4554b2ce1bc4c7e6277a6e6eb7458e34b7a37a767f175e4371eb1c8e"
  end

  on_linux do
    depends_on "zlib-ng-compat"
  end

  deny_network_access!

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}", "dist/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    cd "ZenLib/Project/GNU/Library" do
      args = ["--disable-debug",
              "--enable-static",
              "--disable-shared"]
      system "./configure", "--build=loongarch64-unknown-linux-gnu", *args
      system "make"
    end

    cd "MediaInfoLib/Project/GNU/Library" do
      args = ["--disable-debug",
              "--enable-static",
              "--disable-shared"]
      system "./configure", "--build=loongarch64-unknown-linux-gnu", *args
      system "make"
    end

    cd "AVPS_DV_Analyzer/Project/GNU/CLI" do
      system "./configure", "--build=loongarch64-unknown-linux-gnu", "--disable-debug", "--enable-staticlibs", "--prefix=#{prefix}"
      system "make", "install"
    end
  end

  test do
    test_mp3 = test_fixtures("test.mp3")
    output = shell_output("#{bin}/dvanalyzer --Header #{test_mp3}")
    assert_match test_mp3.to_s, output

    assert_match version.to_s, shell_output("#{bin}/dvanalyzer --Version")
  end
end
