class Potrace < Formula
  desc "Convert bitmaps to vector graphics"
  homepage "https://potrace.sourceforge.net/"
  url "https://potrace.sourceforge.net/download/1.16/potrace-1.16.tar.gz"
  sha256 "be8248a17dedd6ccbaab2fcc45835bb0502d062e40fbded3bc56028ce5eb7acc"
  license "GPL-2.0-or-later"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "c6dd8698c426323c4807c132cad80bd49cd0979fea49c81a46dbb9463cadbe11"
  end

  livecheck do
    url :homepage
    regex(/href=.*?potrace[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  on_linux do
    depends_on "zlib-ng-compat"
  end

  resource "head.pbm" do
    url "https://potrace.sourceforge.net/img/head.pbm"
    sha256 "3c8dd6643b43cf006b30a7a5ee9604efab82faa40ac7fbf31d8b907b8814814f"
  end

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--mandir=#{man}",
                          "--with-libpotrace",
                          *std_configure_args
    system "make", "install"
  end

  test do
    resource("head.pbm").stage testpath
    system bin/"potrace", "-o", "test.eps", "head.pbm"
    assert_path_exists testpath/"test.eps"
  end
end
