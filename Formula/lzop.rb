class Lzop < Formula
  desc "File compressor"
  homepage "https://www.lzop.org/"
  url "https://www.lzop.org/download/lzop-1.04.tar.gz"
  sha256 "7e72b62a8a60aff5200a047eea0773a8fb205caf7acbe1774d95147f305a2f41"
  license "GPL-2.0-or-later"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "ea5c236129034c089016621d7d0fa1500b7bfb43316686901d1d833bd1a5846b"
  end

  livecheck do
    url "https://www.lzop.org/download/"
    regex(/href=.*?lzop[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  depends_on "lzo"

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    path = testpath/"test"
    text = "This is Homebrew"
    path.write text

    system bin/"lzop", "test"
    assert_path_exists testpath/"test.lzo"
    rm path

    system bin/"lzop", "-d", "test.lzo"
    assert_equal text, path.read
  end
end
