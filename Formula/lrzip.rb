class Lrzip < Formula
  desc "Compression program with a very high compression ratio"
  homepage "https://github.com/ckolivas/lrzip"
  url "https://github.com/ckolivas/lrzip/releases/download/v0.7.3/lrzip-0.7.3.tar.xz"
  sha256 "6928862de7c4bbb3cfbcd12fae9fd0a7d230d5bbf27486e52c4de60717ebfdbb"
  license "GPL-2.0-or-later"
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "7db4a133524c47c0de733cee03d7ef733530c03ea50860b7c9664e04448a7384"
  end

  version_scheme 1
  head "https://github.com/ckolivas/lrzip.git", branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end


  depends_on "lz4"
  depends_on "lzo"

  uses_from_macos "bzip2"

  on_linux do
    depends_on "zlib-ng-compat"
  end

  conflicts_with "lrzsz", because: "both install `lrz` binaries"

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "./configure", "--build=loongarch64-unknown-linux-gnu", *std_configure_args
    system "make", "SHELL=bash"
    system "make", "install"
  end

  test do
    path = testpath/"data.txt"
    original_contents = "." * 1000
    path.write original_contents

    # compress: data.txt -> data.txt.lrz
    system bin/"lrzip", "-o", "#{path}.lrz", path
    path.unlink

    # decompress: data.txt.lrz -> data.txt
    system bin/"lrzip", "-d", "#{path}.lrz"
    assert_equal original_contents, path.read
  end
end
