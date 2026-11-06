class Jpeg < Formula
  desc "Image manipulation library"
  homepage "https://www.ijg.org/"
  url "https://www.ijg.org/files/jpegsrc.v10.tar.gz"
  mirror "https://fossies.org/linux/misc/jpegsrc.v10.tar.gz"
  sha256 "8b9eaa13242690ebd03e1728ab1edf97a81a78ed6e83624d493655f31ac95ab5"
  license "IJG"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "b37a537f0acc0bd95fc184f3f89205573223727ee1923b69b739763cf32adcc2"
  end

  livecheck do
    url "https://www.ijg.org/files/"
    regex(/href=.*?jpegsrc[._-]v?(\d+[a-z]?)\.t/i)
  end


  keg_only "it conflicts with `jpeg-turbo`"

  deny_network_access!

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "./configure", "--build=loongarch64-unknown-linux-gnu", *std_configure_args, "--disable-silent-rules"
    system "make", "install"
  end

  test do
    system bin/"djpeg", test_fixtures("test.jpg")
  end
end
